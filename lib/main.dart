import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/student_login.dart';
import 'screens/teacher_login.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Smart Quiz App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => homePage(),
        '/studentLogin': (context) =>  studentLogin(),
        '/teacherLogin': (context) =>  teacherLogin(),
      },
    );
  }
}