import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'student_dashboard.dart';
import 'regestrationForm.dart';

class studentLogin extends StatefulWidget{
  studentLogin({super.key});
  
  @override
  State<studentLogin> createState() => _studentLoginState();
}

class _studentLoginState extends State<studentLogin> {

  final TextEditingController txtControlerID = TextEditingController();
  final TextEditingController txtControlerPassword = TextEditingController();

  bool _isLoading = false;


  @override
  void dispose(){
    txtControlerID.dispose();
    txtControlerPassword.dispose();
    super.dispose();
  }

  Future<void> _userLogin() async{
    String id = txtControlerID.text.trim();
    String password = txtControlerPassword.text.trim();

    if(id.isEmpty || password.isEmpty) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kindly fill all the fields"),),
        );
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String email = "$id@quizapp.com";

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if(context.mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDashboard()));
      }
      return;
    } on FirebaseAuthException catch (e){
      if(context.mounted){
        String msg = "Login Error!!";
        if(e.code == 'user-not-found' || e.code == 'invalid-credential'){
          msg = "Account not found!!";
        }
        else if(e.code == 'wrong-password'){
          msg = "Kindly check your password";
        }
        else if(e.code == 'invalid-email'){
          msg = "User id do not found";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(msg),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    catch (e){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("An error appears! Kindly try in a while"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if(context.mounted){
      setState(() {
        _isLoading = false;
      });
    }
  }



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
        child: SingleChildScrollView(
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
                        top: 230,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)
                                )
                            ),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 20,),
                                  TextField(
                                    controller: txtControlerID,
                                    decoration: InputDecoration(
                                        label: Text('Sap ID',style: TextStyle(color: Colors.grey),),
                                        prefixIcon: Icon(Icons.perm_identity_rounded),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  TextField(
                                    controller: txtControlerPassword,
                                    decoration: InputDecoration(
                                        label: Text('Password',style: TextStyle(color: Colors.grey),),
                                        prefixIcon: Icon(Icons.password),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50)
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: _isLoading
                                      ? const Center(child: CircularProgressIndicator(),)
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.purple,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: (){
                                          _userLogin();
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDashboard()));
                                        },
                                        child: Text('Verify')
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Divider(
                                    color: Colors.purple,
                                    thickness: 1.0,
                                    indent: 10.0,
                                    endIndent: 10.0,
                                    height: 20.0,
                                  ),
                                  SizedBox(height: 20,),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.purple,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Registrationform()));
                                        },
                                        child: Text('Signup')
                                    ),
                                  ),
                                ],
                              ),
                            )
                        )
                    ),
                  ],
                ),
              )
          ),
        )
      ),
    );
  }
}
