import 'package:flutter/material.dart';
import 'package:gtu_question_paper/home/home.dart';

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gtu Question Paper',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
