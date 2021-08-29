import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/constants.dart';

class BranchCard extends StatelessWidget {
  BranchCard({required this.branchName, required this.imgSrc});

  final String branchName;
  final String imgSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(13),
        gradient:
            LinearGradient(colors: [kCardGradientFirst, kCardGradientSecond]),
      ),
      child: Column(
        children: [
          Spacer(),
          Hero(
            tag: branchName,
            child: SvgPicture.network(
              imgSrc,
              placeholderBuilder: (context) => CircularProgressIndicator(),
              height: 80,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              branchName,
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                  fontSize: 18,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
