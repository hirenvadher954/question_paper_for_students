import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/searchBar.dart';
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
              height: size.height * 0.38,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kCardGradientFirst, kCardGradientSecond])),
              child: Stack(
                children: [
                  Positioned(
                    right: -size.width * 0.22,
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width * .6,
                    child: Text(
                        "ipsum is text is written by me to check wheater text fit in proper."),
                  ),
                  SizedBox(
                    width: size.width * .5,
                    child: SearchBar(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      SemCard(
                        semester: "1 & 2",
                      ),
                      SemCard(
                        semester: "3",
                      ),
                      SemCard(
                        semester: "4",
                      ),
                      SemCard(
                        semester: "5",
                      ),
                      SemCard(
                        semester: "6",
                      ),
                      SemCard(
                        semester: "7",
                      ),
                      SemCard(
                        semester: "8",
                      ),
                    ],
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

class SemCard extends StatelessWidget {
  const SemCard({required this.semester});

  final String semester;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth / 2 - 10,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 17),
                  blurRadius: 23,
                  spreadRadius: -13,
                  color: kShadowColor)
            ]),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 43,
              decoration:
                  BoxDecoration(color: kBlueColor, shape: BoxShape.circle),
              child: Icon(Icons.play_arrow, color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Sem $semester",
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      );
    });
  }
}
