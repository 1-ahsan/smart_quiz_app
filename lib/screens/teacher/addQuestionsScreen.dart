import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddQuestionAcreen extends StatefulWidget{
  final String quizTitle;
  final String coursName;
  final String description;

  AddQuestionAcreen({

    super.key,
    required this.quizTitle,
    required this.coursName,
    required this.description,
  });

  @override
  State<AddQuestionAcreen> createState() => _AddQuestionAcreenStates();
}

class _AddQuestionAcreenStates extends State<AddQuestionAcreen>{

  final TextEditingController _txtControlerQuestion = TextEditingController();
  final List<TextEditingController> _txtControllersOptions = List.generate(4, (index) => TextEditingController());

  List<Map<String, dynamic>> _questions = [];

  String _questionType = "MCQ";
  int _correctAnswer = 0;
  bool _isSave = false;

  @override
  void dispose(){
    _txtControlerQuestion.dispose();
    for(var c in _txtControllersOptions){
      c.dispose();
    }
    super.dispose();
  }

  void _addQuestion() {
    String question = _txtControlerQuestion.text.trim();

    if(question.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kindly enter the question.")),
      );
    }

    Map<String, dynamic> newQuestion = {
      "questionText": question,
      "type": _questionType,
    };

    if(_questionType == 'MCQ') {
      List<String> options = [];
      for(var controller in _txtControllersOptions){
        if (controller.text.trim().isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please fill all 4 options.")),
          );
          return;
        }
        options.add(controller.text.trim());
      }
      newQuestion['options'] = options;
      newQuestion ['correctAnswer'] = options[_correctAnswer];
    } else {
      newQuestion['options'] = [];
      newQuestion ['correctAnswer'] = '';
    }

    setState(() {
      _questions.add(newQuestion);
      _txtControlerQuestion.clear();
      for(var controller in _txtControllersOptions){
        controller.clear();
      }
      _correctAnswer=0;
    });
  }

  Future<void> _saveQuizToFireStore() async{
    if (_questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one question.")),
      );
      return;
    }

    setState(() {
      _isSave = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      DocumentReference ref = FirebaseFirestore.instance.collection("quizzes").doc();

      await ref.set({
        'quizId': ref.id,
        'title': widget.quizTitle,
        'courseName': widget.coursName,
        'description': widget.description,
        'teacherId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'questionCount': _questions.length,
        'questions': _questions,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Quiz Created Successfully!")),
        );
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSave = false;
        });
      }
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Add Questions (${_questions.length})")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- INPUT FORM ---
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButton<String>(
                      value: _questionType,
                      isExpanded: true,
                      items: ['MCQ', 'Short Answer'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) => setState(() => _questionType = newValue!),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _txtControlerQuestion,
                      decoration: const InputDecoration(
                        labelText: "Question Text",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (_questionType == 'MCQ') ...[
                      const Text("Select Correct Answer:"),
                      for (int i = 0; i < 4; i++)
                        RadioListTile(
                          value: i,
                          groupValue: _correctAnswer,
                          title: TextField(
                            controller: _txtControllersOptions[i],
                            decoration: InputDecoration(labelText: "Option ${i + 1}"),
                          ),
                          onChanged: (val) => setState(() => _correctAnswer = val as int),
                        ),
                    ],

                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _addQuestion,
                      child: const Text("Add Question"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- LIST OF QUESTIONS ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_questions[index]['questionText']),
                  subtitle: Text(_questions[index]['type']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => setState(() => _questions.removeAt(index)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed:  _isSave ? null : _saveQuizToFireStore,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
          child: _isSave ? const CircularProgressIndicator() : const Text("SAVE QUIZ"),
        ),
      ),
    );
  }
}