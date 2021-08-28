import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/constants.dart';
import 'package:gtu_question_paper/repository/find_paper/models/FindPaper.dart';

class DetailFindPaper extends StatelessWidget {
  DetailFindPaper({required this.branchDetail});

  final FindPaper branchDetail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                color: kBlueLightColor,
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -size.width * 0.1,
                    top: size.height * 0.12,
                    child: Hero(
                      tag: branchDetail.branchName,
                      child: SvgPicture.network(
                        branchDetail.imgSrc,
                        placeholderBuilder: (context) =>
                            CircularProgressIndicator(),
                        width: size.width * 0.6,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    branchDetail.branchName,
                    style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold, fontSize: 35),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
