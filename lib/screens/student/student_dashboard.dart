import 'package:flutter/material.dart';
import 'profilePage.dart';
import 'quizList.dart';


class StudentDashboard extends StatefulWidget {
  StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}



class _StudentDashboardState extends State<StudentDashboard> {

  int _index=0;

  final List<Widget> _pages = [
    quizesList(),
    profile(),
    Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('View Available Quizzes'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            child: const Text('View Submitted Quizzes'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            child: const Text('View Results'),
          ),
        ],
      ),
    ),



  ];


  @override
  Widget build(BuildContext context){



    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: IconButton(
            onPressed: (){

            },
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset("assets/images/hatLogo.png"),
            height: 30,
            width: 30,
          )
        ),
        title: Text(
          "Student's Dashboard",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                
              },
              icon: Icon(Icons.search),
          ),
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.notifications),
          ),
          IconButton(
              onPressed: (){
                
              }, 
              icon: Icon(Icons.info_rounded),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/purpleBackground.png",
                ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _index,
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
            label: "Quizes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }

}
