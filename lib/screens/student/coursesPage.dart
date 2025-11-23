import 'package:flutter/material.dart';
import 'courseCard.dart';

class courses extends StatefulWidget{
  courses({super.key});

  @override
  State<courses> createState() => _courseStates();
}


class _courseStates extends State<courses>{
  



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16),
        child: Column(
          children: [
            courseCard(),
          ],
        ),
      ),
    );
  }
}