import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gtu_question_paper/services/auth.dart';
import 'package:gtu_question_paper/services/database.dart';
import 'package:gtu_question_paper/theme.dart';
import 'package:provider/provider.dart';

import 'app/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
        create: (context) => Auth(),
        child: MaterialApp(
          title: 'GTU Question Paper',
          theme: theme,
          themeMode: ThemeMode.light,
          home:
              // SearchQuestion(),

              LandingPage(
            databaseBuilder: (uid) => FirestoreDataBase(uid: uid),
          ),
        ));
  }
}
