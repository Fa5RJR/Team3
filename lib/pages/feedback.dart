import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: FeedbackPage()));

class FeedbackPage extends StatefulWidget {
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  int _rate = 5;
  final Color teal = const Color(0xFF00897B);

  void _submit() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('✅ Done'),
          content: Text('Thanks for your feedback, ${_name.text}!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _formKey.currentState!.reset();
                _name.clear();
                _email.clear();
                _message.clear();
                setState(() => _rate = 5);
              },
              child: const Text('Close'),
            )
          ],
        ),
      );
    }
  }

  String? _emailValidator(String? v) {
    return (v == null || !RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v)) ? 'Invalid email' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: const Text('Feedback', style: TextStyle(fontSize: 22)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset('assets/image/icon.jpg', height: 50, width: 50, fit: BoxFit.cover),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                      labelText: 'Name', prefixIcon: Icon(Icons.person_outline)),
                  validator: (v) => v!.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                  validator: _emailValidator,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: _rate,
                  items: List.generate(10, (i) => DropdownMenuItem(value: i + 1, child: Text('${i + 1}'))),
                  onChanged: (v) => setState(() => _rate = v!),
                  decoration: const InputDecoration(
                      labelText: 'Rate', prefixIcon: Icon(Icons.star_border)),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _message,
                  decoration: const InputDecoration(
                      labelText: 'Your feedback',
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.feedback_outlined)),
                  maxLines: 4,
                  validator: (v) => v!.isEmpty ? 'Write your feedback' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _submit,
                  child: const Text('Send', style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
