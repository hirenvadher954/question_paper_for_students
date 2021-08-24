import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gtu_question_paper/app/home/home_page.dart';
import 'package:gtu_question_paper/services/auth.dart';
import 'package:gtu_question_paper/services/database.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  LandingPage({required this.databaseBuilder});

  final Database Function(String) databaseBuilder;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {

            }
            return Provider<Database>(
              create: (_) => databaseBuilder(user!.uid),
              child: HomePage(),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
