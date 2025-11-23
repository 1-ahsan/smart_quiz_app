import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget{
  QuizScreen({super.key});

  State<QuizScreen> createState() => _quizScreenState();
}

class _quizScreenState extends State<QuizScreen> {

  Widget option(String op) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.grey,
        ),
        
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(

        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(op,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
              padding: EdgeInsets.all(0),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 300,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/purpleBackground.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 150,),

                 Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      color: Colors.white
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                            child: Text(
                                "1/10",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("What is 439 + 9? "),
                          SizedBox(height: 10,),
                          option("447"),
                          SizedBox(height: 10,),
                          option("530"),
                          SizedBox(height: 10,),
                          option("448"),
                          SizedBox(height: 10,),
                          option("443"),
                          SizedBox(height: 10,),

                          SizedBox(height: 10,),

                          ElevatedButton(
                              onPressed: (){

                              },
                              child: Text("Next"),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}