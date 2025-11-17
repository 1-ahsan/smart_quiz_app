import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:smart_quiz_app/screens/student_dashboard.dart';
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
    // Show loading circle
    setState(() {
      _isLoading = true;
    });

    try {
      // --- THIS IS THE NEW LOGIC ---
      // Get the Sap ID and create a "fake" email for Firebase Auth
      String sapId = txtControllerId.text.trim();
      String password = txtControllerPassword.text.trim();

      // IMPORTANT: Use a domain you control or a placeholder like @quizapp.com
      String fakeEmail = "$sapId@quizapp.com";
      // --- END NEW LOGIC ---


      // Step 1: Create user with Firebase Auth using the FAKE email
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: fakeEmail, // Use the fake email
        password: password,
      );

      // Step 2: Save additional data to Cloud Firestore
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        // Using .set() will create the document if it doesn't exist
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'sapId': sapId, // Store the REAL Sap ID
          'fullName': txtControllerName.text.trim(),
          'semester': txtControllerSemester.text.trim(),
          'email': fakeEmail, // Store the fake email for reference
          'role': 'student', // Good to add a role
          'createdAt': FieldValue.serverTimestamp(), // To know when they joined
        });

        // Step 3: Navigate to Dashboard
        if (context.mounted) {
          // Use pushReplacement so the user can't go "back" to the registration page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => studentLogin()),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors (e.g., email already in use, weak password)
      if (context.mounted) {
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
      // Handle any other errors
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("An unexpected error occurred. Please try again.")),
        );
      }
    }

    if (context.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
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
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
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