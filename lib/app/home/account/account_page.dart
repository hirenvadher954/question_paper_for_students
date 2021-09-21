import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/common_widgets/avatar.dart';
import 'package:gtu_question_paper/common_widgets/show_alert_dialog.dart';
import 'package:gtu_question_paper/services/auth.dart';
import 'package:provider/provider.dart';

import 'contact_us/contact_us.dart';
import 'privacy_policy/PrivacyPolicy.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text('Account'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.2),
          child: _buildUserInfo(auth.currentUser!),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            buildButtons(size, context, "Contact Us", GradientColors.blue,
                ContactUsPage()),
            buildButtons(size, context, "Privacy Policy", GradientColors.blue,
                PrivacyPolicy()),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(Size size, BuildContext context, String text,
      List<Color> colors, Widget screenName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screenName));
        },
        child: Container(
          height: size.height * 0.1,
          decoration: new BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
            text,
            style:
                GoogleFonts.robotoCondensed(fontSize: 20, color: Colors.white),
          )),
        ),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: <Widget>[
        Avatar(
          photoUrl: user.photoURL,
          radius: 50,
        ),
        SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName!.capitalizeFirstofEach,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        SizedBox(height: 8),
      ],
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.inCaps).join(" ");
}
