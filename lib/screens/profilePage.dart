import 'package:flutter/material.dart';


class profile extends StatelessWidget {
  const profile({super.key});

  Widget profileCart (){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple,
              ),
              height: 100,
              width: 100,
              child: Icon(
                Icons.school_outlined,
                color: Colors.white,
                size: 72,
              ),
            ),
            SizedBox(width: 100,),
            Column(
              children: [
                Text(
                  "Ahsan Abbas",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Text(
                  "Member Since Sep 2023",
                  style: TextStyle(
                    color: Colors.purpleAccent,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget settingCard(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account Setting",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.edit,color: Colors.purple,),
                SizedBox(width: 10,),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.purple,
                    wordSpacing: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
              indent: 10.0,
              endIndent: 10.0,
              height: 20.0,
            ),
            Row(
              children: [
                Icon(Icons.settings,color: Colors.purple,),
                SizedBox(width: 10,),
                Text(
                  "Account Setting",
                  style: TextStyle(
                    color: Colors.purple,
                    wordSpacing: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      )
    );
  }

  Widget logoutCart(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Container(
        margin: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.exit_to_app, color: Colors.purple,),
            SizedBox(width: 10,),
            Text(
                "Log out",
              style: TextStyle(
                color: Colors.purple,
                wordSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(5),
        child: Column(
          children: [
            profileCart(),
            settingCard(),
            logoutCart(),
          ],
        ),
      ),
    );
  }
}