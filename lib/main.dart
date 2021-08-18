import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gtu_question_paper/app/bloc_observer.dart';

import 'app/app.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(AppView());
}
