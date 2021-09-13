import 'package:flutter/material.dart';
import 'package:gtu_question_paper/app/sign_in/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: EmailSignInFormChangeNotifier.create(context),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
