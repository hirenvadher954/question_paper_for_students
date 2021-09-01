import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/app/home/detail_find_paper/widgets/sem_card.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/searchBar.dart';
import 'package:gtu_question_paper/app/home/subject_selection_screen/subject_selection_screen.dart';
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
                  SingleChildScrollView(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: _buildSemCardList(context, branchDetail),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSemCardList(context, FindPaper branchDetail) {
    List<Widget> listItems = [];
    for (int i = 0; i < branchDetail.semester.keys.length; i++) {
      listItems.add(InkWell(
          onTap: () => _gotoSubjectPage(
                context,
                branchDetail,
                // branchDetail.semester.values.elementAt(i),
              ),
          child: AnimationConfiguration.staggeredGrid(
              position: i,
              columnCount: 2,
              duration: const Duration(milliseconds: 800),
              child: SlideAnimation(
                  child: SemCard(
                      semester: branchDetail.semester.keys.elementAt(i))))));
    }
    return listItems;
  }

  _gotoSubjectPage(context, curruntBranch) {
    print(curruntBranch);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubjectSelectionScreen(
              branchDetail: curruntBranch,
                )));
  }
}
