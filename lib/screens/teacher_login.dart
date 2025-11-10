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
              padding: EdgeInsets.all(0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                        height: 300,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/purpleBackground.png"),
                                fit: BoxFit.cover,
                              )
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign Up Now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      color: Colors.white
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text("Join the smart Quiz app",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                    ),

                    Positioned(
                        top: 250,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)
                                )
                            ),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 50,),
                                  TextField(
                                    controller: txtControlerPassword,
                                    decoration: InputDecoration(
                                        label: Text('Email',style: TextStyle(color: Colors.grey),),
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder()
                                    ),
                                  ),
                                  SizedBox(height: 20,),
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
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => teacherDashboard()));
                                      },
                                      child: Text('Verify')
                                  )
                                ],
                              ),
                            )
                        )
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }
}