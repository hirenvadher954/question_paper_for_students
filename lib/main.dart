import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gtu_question_paper/app/landing_page.dart';
import 'package:gtu_question_paper/services/auth.dart';
import 'package:gtu_question_paper/services/database.dart';
import 'package:gtu_question_paper/theme.dart';
import 'package:provider/provider.dart';

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
            // PaperSelectionScreen(
            //   subjectName: "ABC",
            //   paperList: {
            //     "2018-summer": "paperlink",
            //     "2019-winter": "paperlink",
            //     "2020-summer": "paperlink",
            //     "2021-winter": "paperlink",
            //     "2022-summer": "paperlink",
            //     "2023-winter": "paperlink",
            //   },
            // ),
            // SubjectSelectionScreen(
            //   branchDetail: FindPaper(
            //       imgSrc:
            //           "https://firebasestorage.googleapis.com/v0/b/gtu-question-paper.appspot.com/o/Branch%20Images%2FIT.svg?alt=media&token=1deaaa58-96d7-4535-a389-0aab5b5c8557",
            //       branchName: "Computer",
            //       semester: {
            //         "1&2": "Java",
            //         "bc":"23",
            //         "cd":"2343"
            //       }),
            //   index: 0,
            // ),
            // DetailFindPaper(
            //   branchDetail: FindPaper(
            //       imgSrc:
            //       "https://firebasestorage.googleapis.com/v0/b/gtu-question-paper.appspot.com/o/Branch%20Images%2FIT.svg?alt=media&token=1deaaa58-96d7-4535-a389-0aab5b5c8557",
            //       branchName: "Conputer Enginerring"),
            // )

            LandingPage(
          databaseBuilder: (uid) => FirestoreDataBase(uid: uid),
        ),
      ),
    );
  }
}
