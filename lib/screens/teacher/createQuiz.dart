import 'package:flutter/material.dart';
import 'addQuestionsScreen.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final TextEditingController _titleController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Helper to pick date
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Helper to pick time
  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Combine Date and Time into one DateTime object
  DateTime? _getDeadline() {
    if (_selectedDate == null || _selectedTime == null) return null;
    return DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Quiz Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 1. Quiz Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Quiz Title",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Date Picker
            ListTile(
              title: Text(_selectedDate == null
                  ? "Pick Due Date"
                  : "Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"),
              leading: const Icon(Icons.calendar_today, color: Colors.deepPurple),
              tileColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onTap: _pickDate,
            ),
            const SizedBox(height: 10),

            // 3. Time Picker
            ListTile(
              title: Text(_selectedTime == null
                  ? "Pick Due Time"
                  : "Time: ${_selectedTime!.format(context)}"),
              leading: const Icon(Icons.access_time, color: Colors.deepPurple),
              tileColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onTap: _pickTime,
            ),

            const SizedBox(height: 40),

            // Next Button
            ElevatedButton(
              onPressed: () {
                // Validation
                if (_titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a Quiz Title")),
                  );
                  return;
                }

                DateTime? deadline = _getDeadline();
                if (deadline == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select both Date and Time")),
                  );
                  return;
                }

                // Navigate to Add Questions Screen with Data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddQuestionAcreen(
                      quizTitle: _titleController.text.trim(),
                      deadline: deadline, // Passing the deadline
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Next: Add Questions", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}