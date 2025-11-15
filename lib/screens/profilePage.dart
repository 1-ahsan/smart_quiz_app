import 'package:flutter/material.dart';


class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset("assets/images/hatLogo.png"),
              height: 30,
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}