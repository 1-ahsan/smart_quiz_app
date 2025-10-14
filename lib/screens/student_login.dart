import 'package:flutter/material.dart';

class studentLogin extends StatefulWidget{
  studentLogin({super.key});
  
  @override
  State<studentLogin> createState() => _studentLoginState();
}

class _studentLoginState extends State<studentLogin> {

  final TextEditingController txtControlerEmail = TextEditingController();
  final TextEditingController txtControlerPassword = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)
        ),
        title: Text(
          "Student's login",
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
