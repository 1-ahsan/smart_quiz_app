import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizScreen extends StatefulWidget{
  final String quizId;
  QuizScreen({
    required this.quizId,
    super.key});

  State<QuizScreen> createState() => _quizScreenState();
}

class _quizScreenState extends State<QuizScreen> {


  List<dynamic> _questions = [];
  int _currentIndex = 0;
  int? _selectedOptionIndex;
  int _score = 0;
  bool _isLoading = true;
  bool _isSubmitting = false;

  Future<void> _fetchQuizData() async {
    try {
      DocumentSnapshot quizDoc = await FirebaseFirestore.instance
          .collection('quizzes')
          .doc(widget.quizId)
          .get();

      if (quizDoc.exists) {
        setState(() {
          _questions = quizDoc['questions'];
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle errors
      setState(() => _isLoading = false);
    }
  }


  void _submitAnswer() {
    if (_selectedOptionIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an option")),
      );
      return;
    }

    // Check Answer
    String selectedAnswer = _questions[_currentIndex]['options'][_selectedOptionIndex];
    String correctAnswer = _questions[_currentIndex]['correctAnswer'];

    if (selectedAnswer == correctAnswer) {
      _score++;
    }

    // Move to next question or Finish
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOptionIndex = null; // Reset selection
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    // Show Result Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Quiz Completed!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 50),
            const SizedBox(height: 10),
            Text(
              "You scored $_score / ${_questions.length}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close Dialog
              Navigator.pop(context); // Go back to List
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }


  Widget option(String text, int index) {
    bool isSelected = _selectedOptionIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOptionIndex = index;
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: isSelected ? Colors.purple : Colors.grey,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        color: isSelected ? Colors.purple.shade50 : Colors.white,
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.purple : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    // Loading State

    _fetchQuizData();
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Empty State (No questions found)
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("No questions found in this quiz.")),
      );
    }

    // Main Quiz UI
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              // Purple Background
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 300,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/purpleBackground.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              // White Content Container
              Column(
                children: [
                  const SizedBox(height: 150),
                  Container(
                    width: double.infinity, // Ensure full width
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView( // Allows content to scroll if long
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          // Question Counter Circle
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                            child: Text(
                              "${_currentIndex + 1}/${_questions.length}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Dynamic Question Text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              _questions[_currentIndex]['questionText'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Dynamic Options List
                          // We use the spread operator (...) to add the list of widgets
                          ...List.generate(
                            _questions[_currentIndex]['options'].length,
                                (index) => option(
                              _questions[_currentIndex]['options'][index],
                              index,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Next/Finish Button
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _submitAnswer,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                _currentIndex == _questions.length - 1 ? "Finish" : "Next",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
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