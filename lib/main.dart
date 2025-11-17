import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCYFwCfkd7Vnig3YUwSnUg9lIgrR0Z3njc",
      appId: "1:605594434298:android:3d1a251128392e5af72743",
      messagingSenderId: "605594434298",
      projectId: "smart-quiz-appp",
    ),
  );
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Smart Quiz App',
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}
