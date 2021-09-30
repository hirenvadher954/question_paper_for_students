import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: GradientColors.skyLine,
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ContactUs(
                companyName: "I'm",
                companyColor: Colors.orangeAccent,
                companyFontSize: 45,
                tagLine: "Flutter Developer",
                textColor: Colors.lightGreenAccent,
                cardColor: Colors.blueGrey,
                taglineColor: Colors.greenAccent,
                email: "hirenvadher954@gmail.com",
                linkedinURL: "https://www.linkedin.com/in/hiren-vadher/",
                githubUserName: "hirenvadher954",
              ),
            ),

            // ContactUsBottomAppBar(
            //   companyName: '',
            //   textColor: Colors.white,
            //   backgroundColor: Colors.teal.shade300,
            //   email: 'hirenvadher954@gmail.com',
            //   // textFont: 'Sail',
            // ),
          ],
        ),
      ),
    );
  }
}
