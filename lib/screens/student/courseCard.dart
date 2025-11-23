import 'package:flutter/material.dart';
import 'quizScreen.dart';



class courseCard extends StatefulWidget{

  courseCard({
    super.key,
    });

  State<courseCard> createState() => _courseCardState();
}

class _courseCardState extends State<courseCard> {

  bool _isExpanded = false;

  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
                  },
                  child: Text("PYTHON",style: TextStyle(fontWeight: FontWeight.bold,),),
                ),
                Icon(Icons.info_rounded),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.info_rounded,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _isExpanded ? "Close Info" : "Info",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),

            AnimatedCrossFade(
              firstChild: Container(height: 0,),
              secondChild: Container(
                child: Column(
                  children: [
                    Text("The information"),
                  ],
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}