import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'student_login.dart';

class Registrationform extends StatefulWidget{
  Registrationform({super.key});

  State<Registrationform> createState() => _regestrationFormState();
}

class _regestrationFormState extends State<Registrationform> {

  final TextEditingController txtControllerId = TextEditingController();
  final TextEditingController txtControllerName = TextEditingController();
  final TextEditingController txtControllerSemester = TextEditingController();
  final TextEditingController txtControllerPassword = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    txtControllerId.dispose();
    txtControllerName.dispose();
    txtControllerSemester.dispose();
    txtControllerPassword.dispose();
    super.dispose();
  }



  Future<void> _registerUser() async {
    // setState(() {
    //   _isLoading = true;
    // });

    try {
      String sapId = txtControllerId.text.trim();
      String password = txtControllerPassword.text.trim();
      String fakeEmail = "$sapId@quizapp.com";

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: fakeEmail,
        password: password,
      );

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'sapId': sapId,
          'fullName': txtControllerName.text.trim(),
          'semester': txtControllerSemester.text.trim(),
          'email': fakeEmail,
          'createdAt': FieldValue.serverTimestamp(),
        });




        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registered")),
          );
          Navigator.pop(context);
        }
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        // setState(() {
        //   _isLoading = false;
        // });

        String message = "Registration failed";
        if (e.code == 'email-already-in-use') {
          message = "This Sap ID is already registered.";
        } else if (e.code == 'weak-password') {
          message = "The password is too weak.";
        } else {
          message = e.message ?? message;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An unexpected error occurred. Please try again.")),
        );
      }
    }
    // if (context.mounted) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            TextField(
              controller: txtControllerId,
              keyboardType: TextInputType.number,
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
              controller: txtControllerName,
              decoration: InputDecoration(
                  label: Text('Full Name',style: TextStyle(color: Colors.grey),),
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: txtControllerSemester,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  label: Text('Semester',style: TextStyle(color: Colors.grey),),
                  prefixIcon: Icon(Icons.class_),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: txtControllerPassword,
              obscureText: true,
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
              child:
                  //     _isLoading
                  // ? Center(child: CircularProgressIndicator())
                  // :
                    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: (){
                    _registerUser();
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => studentLogin()));
                  },
                  child: Text('Register')
              ),
            ),
          ],
        ),
      ),
    );
  }
}