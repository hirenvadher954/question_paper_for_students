import 'package:facebook_audience_network/facebook_audience_network.dart';
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FacebookAudienceNetwork.init();
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
          home:
              // home: Scaffold(
              //   appBar: AppBar(
              //     title: Text("hiren"),
              //   ),
              //   body: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: <Widget>[
              //           ElevatedButton(
              //               onPressed: () {
              //                 print("banner Ad");
              //                 try {
              //                   setState(() {
              //                     facebookBannerAd = FacebookBannerAd(
              //                       placementId:
              //                           AdUnitId.standardBannerId,
              //                       bannerSize: BannerSize.STANDARD,
              //                       listener: (result, val) {
              //                         print(val);
              //                         print(result);
              //                       },
              //                     );
              //                   });
              //                 } catch (e, s) {
              //                   print(s);
              //                 }
              //               },
              //               child: Text("Banned Ad")),
              //           ElevatedButton(
              //               onPressed: () {
              //                 print("Native Ad");
              //               },
              //               child: Text("Native Ad"))
              //         ],
              //       ),
              //       Spacer(),
              //       Container(
              //         child: facebookBannerAd,
              //       ),
              //       SizedBox(
              //         height: 50,
              //       ),
              //       Container(
              //         child: null,
              //       ),
              //     ],
              //   ),
              // ),
              // ContactUsPage(),

              LandingPage(
            databaseBuilder: (uid) => FirestoreDataBase(uid: uid),
          ),
        ));
  }
}
