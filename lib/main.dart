// import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gtu_question_paper/services/auth.dart';
import 'package:gtu_question_paper/services/database.dart';
import 'package:gtu_question_paper/theme.dart';
import 'package:provider/provider.dart';

import 'app/landing_page.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
        create: (context) => Auth(),
        child: MaterialApp(
          title: 'GTU Question Paper',
          theme: theme,
          themeMode: ThemeMode.light,
          home: LandingPage(
            databaseBuilder: (uid) => FirestoreDataBase(uid: uid),
          ),
        ));
  }
}
