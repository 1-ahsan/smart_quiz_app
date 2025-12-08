import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizSubmissionsScreen extends StatelessWidget {
  final String quizId;
  final String quizTitle;

  const QuizSubmissionsScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results: $quizTitle"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Listen to the 'submissions' collection for THIS quiz ID
        stream: FirebaseFirestore.instance
            .collection('submissions')
            .where('quizId', isEqualTo: quizId)
        // REMOVED: .orderBy('score', descending: true)
        // Why? This requires a Firestore Composite Index.
        // We will sort it manually in the builder below to avoid errors.
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Print the actual error to the console for debugging
            debugPrint("Error fetching submissions: ${snapshot.error}");
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Get the list of docs
          var submissions = snapshot.data!.docs;

          // --- MANUAL SORTING FIX ---
          // Sort by score descending (highest first)
          submissions.sort((a, b) {
            var dataA = a.data() as Map<String, dynamic>;
            var dataB = b.data() as Map<String, dynamic>;
            int scoreA = dataA['score'] ?? 0;
            int scoreB = dataB['score'] ?? 0;
            return scoreB.compareTo(scoreA); // B compared to A gives descending order
          });
          // --------------------------

          if (submissions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_late_outlined, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 20),
                  const Text(
                    "No submissions yet.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          // Calculate Summary Stats
          double totalScore = 0;
          int totalMaxScore = 0;

          if (submissions.isNotEmpty) {
            // Just taking the total from the first doc as assumption that all are same
            var firstData = submissions.first.data() as Map<String, dynamic>;
            int quizMax = firstData['totalQuestions'] ?? 1;

            for (var doc in submissions) {
              var data = doc.data() as Map<String, dynamic>;
              totalScore += (data['score'] ?? 0);
            }
            totalMaxScore = quizMax * submissions.length;
          }

          double averagePercent = totalMaxScore > 0 ? (totalScore / totalMaxScore) * 100 : 0;

          return Column(
            children: [
              // --- SECTION 1: SUMMARY HEADER ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  border: Border(bottom: BorderSide(color: Colors.deepPurple.shade100)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryItem("Total Students", "${submissions.length}"),
                    _buildSummaryItem("Average Score", "${averagePercent.toStringAsFixed(1)}%"),
                  ],
                ),
              ),

              // --- SECTION 2: STUDENT LIST ---
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: submissions.length,
                  itemBuilder: (context, index) {
                    var sub = submissions[index].data() as Map<String, dynamic>;
                    String name = sub['studentName'] ?? 'Unknown Student';
                    int score = sub['score'] ?? 0;
                    int total = sub['totalQuestions'] ?? 0;

                    // Logic for Grade Color (Green if > 50%, Red if < 50%)
                    double percentage = total > 0 ? (score / total) : 0;
                    Color gradeColor = percentage >= 0.5 ? Colors.green : Colors.red;
                    String gradeLabel = percentage >= 0.5 ? "PASS" : "FAIL";

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : "?",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text("Student ID: ${sub['studentId']?.toString().substring(0, 5) ?? '...'}..."), // Shortened ID
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "$score / $total",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(
                                  gradeLabel,
                                  style: TextStyle(
                                      color: gradeColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              percentage >= 0.5 ? Icons.check_circle : Icons.cancel,
                              color: gradeColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Helper widget for the summary stats at the top
  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.deepPurple.shade300,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}