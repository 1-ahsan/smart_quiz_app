import 'package:flutter/material.dart';
import 'studentDashboardpage.dart';
//

class StudentDashboard extends StatefulWidget {
  StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}



class _StudentDashboardState extends State<StudentDashboard> {

  int _index=0;

  final List<Widget> _pages = [
    Dashboard(),
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
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(
              Icons.dashboard_customize),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity_rounded),
            label: "Profile",
          )
        ],
      ),
    );
  }

}

// class studentDashboard extends StatelessWidget {
//   studentDashboard({super.key});
//
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: (){
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back)
//         ),
//         title: Text(
//           "Teacher's Dashboard",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text('View Available Quizzes'),
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text('View Submitted Quizzes'),
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text('View Results'),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.purple,
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(icon: Icon(
//               Icons.dashboard_customize),
//             label: "Home",
//           )
//         ],
//       ),
//     );
//   }
// }