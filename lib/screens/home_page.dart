import 'package:flutter/material.dart';
import 'teacher/teacher_login.dart';
import 'student/student_login.dart';

class homePage extends StatelessWidget {
  homePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          "Smart Quiz App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(
                  'Welcome to the App!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                Image(image: AssetImage('assets/images/logo.png')),
                SizedBox(height: 200),
                Text(
                  'Kindly Select the Login Method',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize:  Size(double.infinity,50),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder:(context) => teacherLogin()));
                          },
                          child: Text('Teacher login')
                      ),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize:  Size(double.infinity,50),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => studentLogin()));
                          },
                          child: Text('Student login')
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}