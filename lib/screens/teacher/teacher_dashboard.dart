import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'teacher_login.dart';
import 'createQuiz.dart';
import 'quizesScreen.dart';
import 'quizList.dart';

class teacherDashboard extends StatelessWidget {
  teacherDashboard({super.key});



  void _logout (BuildContext context) async{
    FirebaseAuth.instance.signOut();
    if(context.mounted){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => teacherLogin()),
          (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Transform.rotate(
            angle: 180 *3.16 / 180,
          child: IconButton(
              onPressed: (){
                _logout(context);
                // Navigator.pop(context);
              },
              icon: Icon(Icons.logout,)
          ),
        ),
        title: Text(
          "Teacher's Dashboard",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuizScreen()));
              },
              child: const Text('Create New Quiz'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherQuizzesListScreen()));
              },
              child: const Text('View Student Submissions'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherQuizListScreen()));
              },
              child: const Text('View All Quizzes'),
            ),
          ],
        ),
      ),
    );
  }
}