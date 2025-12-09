import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'quizScreen.dart';

class quizesList extends StatelessWidget {


  const quizesList({
    super.key,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'graded':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'missed':
        return Colors.red;
      case 'submitted':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Widget _quizes(BuildContext context, DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // We get the ID so we can load the specific questions later
    String quizId = doc.id;
    String title = data['title'] ?? 'Untitled Quiz';

    // In a real app, you would check a 'submissions' collection to see the status
    String dueDate = "25 Oct";

    User? user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('submissions')
            .where('quizId', isEqualTo: quizId)
            .where('studentId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {

          String currentStatus = "Pending";
          String? marks;
          String? total;
          bool isSubmitted = false;

          // Check if we have data (meaning a submission exists)
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var submissionData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
            isSubmitted = true;
            currentStatus = "Graded"; // Assuming auto-graded means it's graded
            marks = submissionData['score'].toString();
            total = submissionData['totalQuestions'].toString();
          }

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            elevation: 4,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: (){
                          // Only allow taking quiz if NOT submitted
                          if (!isSubmitted) {
                            Navigator.push(context, MaterialPageRoute(builder:  (context) => QuizScreen(quizId: quizId)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("You have already submitted this quiz."))
                            );
                          }
                        },
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSubmitted ? Colors.grey : Colors.black87, // Grey out if done
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        decoration: BoxDecoration(
                          color: _getStatusColor(currentStatus).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: _getStatusColor(currentStatus),width: 1),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          currentStatus.toUpperCase(),
                          style: TextStyle(
                            color: _getStatusColor(currentStatus),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),

                  const Divider(height: 25, thickness: 1),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded),
                          const SizedBox(width: 5,),
                          Text(
                            "Due: $dueDate",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      // Show Grade if submitted, otherwise show arrow
                      if (isSubmitted && marks != null)
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Grade: ",
                                style: TextStyle(color: Colors.black54, fontSize: 14),
                              ),
                              TextSpan(
                                text: "$marks",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: "/$total",
                                style: const TextStyle(color: Colors.black54, fontSize: 14),
                              ),
                            ],
                          ),
                        )
                      else
                      // Shows a simple icon if it's pending
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.grey[400],
                        ),


                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );

  }

  Widget info(){
    return Card(
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(text: TextSpan(
              children: [
                TextSpan(
                  text: "Instructor: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: "Instructor Name",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ]
              ),
            ),
            SizedBox(height: 5,),
            Text("        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),

          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: Column(
        children: [
          info(),

          // --- THIS IS THE MAJOR CHANGE ---
          // Instead of showing 1 static quiz, we fetch ALL quizzes from Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('quizzes').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Center(child: Text("Error loading quizzes"));
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final quizzes = snapshot.data!.docs;

                if (quizzes.isEmpty) {
                  return const Center(child: Text("No quizzes available yet."));
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    return _quizes(context, quizzes[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


