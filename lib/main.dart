import 'package:flutter/material.dart';
import 'package:smart_quiz_app/screens/student_dashboard.dart';
import 'screens/home_page.dart';
import 'screens/student_login.dart';
import 'screens/teacher_login.dart';
import 'screens/teacher_dashboard.dart';
import 'screens/student_dashboard.dart';

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
        '/teacherDashboard': (context) => teacherDashboard(),
        '/studentDashboard': (context) => studentDashboard(),

      },
    );
  }
}