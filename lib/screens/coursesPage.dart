import 'package:flutter/material.dart';

class courses extends StatelessWidget{
  courses({super.key});

  Widget course(){
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
                Text("PYTHON",style: TextStyle(fontWeight: FontWeight.bold,),),
                Icon(Icons.info_rounded)
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16),
        child: Column(
          children: [
            course(),
            Text("data")
          ],
        ),
      ),
    );
  }
}