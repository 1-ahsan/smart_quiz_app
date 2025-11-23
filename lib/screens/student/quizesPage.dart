import 'package:flutter/material.dart';
import 'quizScreen.dart';

class quizesPage extends StatelessWidget {
  final String quizTitle;
  final String courseTitle = "Course Title";
  final String status; // 'Pending', 'Graded', 'Missed', 'Submitted'
  final String dueDate;
  final String? obtainedMarks; // Nullable, only needed if graded
  final String? totalMarks;


  const quizesPage({
    super.key,
    required this.quizTitle,
    required this.status,
    required this.dueDate,
    this.obtainedMarks,
    this.totalMarks,
  });

  Color _getStatusColor() {
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

  Widget quizes(BuildContext context){
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
                      Navigator.push(context, MaterialPageRoute(builder:  (context) => QuizScreen()));
                    },
                    child: Text(
                      quizTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                ),
                SizedBox(width: 5,),
                Container(
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _getStatusColor(),width: 1),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(),
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

                if (status.toLowerCase() == 'graded' && obtainedMarks != null)
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Grade: ",
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        TextSpan(
                          text: "$obtainedMarks",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: "/$totalMarks",
                          style: const TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                      ],
                    ),
                  )
                else
                // Shows a simple icon if it's pending/submitted
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(Icons.arrow_back),
              height: 30,
              width: 30,
            )
        ),
        title: Text(
          courseTitle.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/purpleBackground.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(1),
        child: ListView(
          children: [
            info(),
            quizes(context),
          ],
        ),
      ),
    );
  }
}


