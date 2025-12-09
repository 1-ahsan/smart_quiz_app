import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_login.dart';

class profile extends StatelessWidget {
  const profile({super.key});


  Future<Map<String, String>> _getUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

          String name = data['fullName'] ?? "Unknown";
          String memberSince = "Unknown Date";

          if (data['createdAt'] != null) {
            Timestamp timestamp = data['createdAt'];
            DateTime date = timestamp.toDate();
            const List<String> months = [
              "Jan", "Feb", "Mar", "Apr", "May", "Jun",
              "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
            ];
            memberSince = "${months[date.month - 1]} ${date.year}";
          }

          return {
            "name": name,
            "date": memberSince,
          };
        }
      }
      return {"name": "User Not Found", "date": ""};
    } catch (e) {
      return {"name": "Error Loading", "date": ""};
    }
  }


  Widget _buildProfileCard() {
    return FutureBuilder<Map<String, String>>(
      future: _getUserDetails(),
      builder: (context, snapshot) {

        String displayName = "Loading...";
        String displayDate = "...";

        // If data is ready, update the values
        if (snapshot.hasData) {
          displayName = snapshot.data!['name'] ?? "Unknown";
          displayDate = snapshot.data!['date'] ?? "";
        }

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple,
                  ),
                  height: 80,
                  width: 80,
                  child: const Icon(
                    Icons.school_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Member Since $displayDate",
                        style: const TextStyle(
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingCard() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account Setting",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Icon(Icons.edit, color: Colors.purple),
                  SizedBox(width: 10),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Divider(height: 30),
              Row(
                children: const [
                  Icon(Icons.settings, color: Colors.purple),
                  SizedBox(width: 10),
                  Text(
                    "App Settings",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }

  Widget _buildLogoutCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () => _logout(context),
          child: Row(
            children: const [
              Icon(Icons.exit_to_app, color: Colors.purple),
              SizedBox(width: 10),
              Text(
                "Log out",
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => studentLogin()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileCard(),
            _buildSettingCard(),
            _buildLogoutCard(context),
          ],
        ),
      ),
    );
  }
}