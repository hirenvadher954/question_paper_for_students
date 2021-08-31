import 'package:flutter/material.dart';

class SubjectSelectionScreen extends StatelessWidget {
  const SubjectSelectionScreen({required this.subjectDetails});

  final Map<String, dynamic> subjectDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Subject Selection SCreen")),
    );
  }
}
