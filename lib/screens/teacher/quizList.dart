import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'quizSubmissionScreen.dart';

class TeacherQuizzesListScreen extends StatelessWidget {
  const TeacherQuizzesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Quiz to View Results"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Fetch quizzes created by the current teacher
        stream: FirebaseFirestore.instance
            .collection('quizzes')
            .where('teacherId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading quizzes"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final quizzes = snapshot.data!.docs;

          if (quizzes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.quiz_outlined, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 20),
                  const Text(
                    "You haven't created any quizzes yet.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              var quizDoc = quizzes[index];
              var quizData = quizDoc.data() as Map<String, dynamic>;
              String title = quizData['title'] ?? 'Untitled Quiz';
              String course = quizData['courseName'] ?? 'No Course';
              int questionCount = quizData['questionCount'] ?? 0;

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade50,
                    child: const Icon(Icons.assignment, color: Colors.deepPurple),
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text("$course • $questionCount Questions"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    // Navigate to the Submissions Screen for this specific quiz
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizSubmissionsScreen(
                          quizId: quizDoc.id,
                          quizTitle: title,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}