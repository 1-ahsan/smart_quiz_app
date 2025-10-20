import 'package:flutter/material.dart';
import 'teacher_dashboard.dart';

class teacherLogin extends StatefulWidget{
  teacherLogin({super.key});

  @override
  State<teacherLogin> createState() => _teacherLoginstate();
}

class _teacherLoginstate extends State<teacherLogin> {


  final TextEditingController txtControlerEmail = TextEditingController();
  final TextEditingController txtControlerPassword = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)
        ),
        title: Text(
          "Teacher's login",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                SizedBox(height: 150,),
                TextField(
                  controller: txtControlerEmail,
                  decoration: InputDecoration(
                      label: Text('Email',style: TextStyle(color: Colors.grey),),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 50,),
                TextField(
                  controller: txtControlerPassword,
                  decoration: InputDecoration(
                      label: Text('Password',style: TextStyle(color: Colors.grey),),
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 50,),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => teacherDashboard()));
                      Navigator.pushNamed(context, '/teacherDashboard');
                    },
                    child: Text('Verify')
                )
              ],
            ),
          )
      ),
    );
  }
}