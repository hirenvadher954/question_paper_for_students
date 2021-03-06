import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                      child: Image.network(
                        branchDetail.imgSrc,
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
                  Hero(
                    tag: branchDetail.semester,
                    transitionOnUserGestures: true,
                    child: SizedBox(
                      width: size.width,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          branchDetail.branchName,
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Hero(
                    tag: 'serchBar',
                    child: SizedBox(
                      width: size.width * .5,
                      child: Material(
                          type: MaterialType.transparency,
                          child: SearchBar(
                            hintText: "Search Solutions",
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
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
    final titleList = branchDetail.semester.keys.toList();

    titleList.sort((a, b) {
      return int.parse(a[0]).compareTo(int.parse(b[0]));
    });
    List<Widget> listItems = [];
    for (int i = 0; i < branchDetail.semester.keys.length; i++) {
      listItems.add(InkWell(
          onTap: () => _gotoSubjectPage(context, branchDetail, i, titleList[i]),
          child: AnimationConfiguration.staggeredGrid(
              position: i,
              columnCount: 2,
              duration: const Duration(milliseconds: 800),
              child: SlideAnimation(
                  child: SemCard(
                      screen: "detailFindPaperScreen",
                      cardTitle: " Sem ${titleList[i]}")))));
    }
    return listItems;
  }

  late FToast fToast;

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: AutoSizeText(
        "Previous Year Paper is not available yet",
        maxLines: 3,
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  _gotoSubjectPage(context, curruntBranch, index, String seletedKey) {
    fToast = FToast();
    fToast.init(context);
    if (branchDetail.semester[seletedKey]["subjects"].keys.toList().isEmpty) {
      _showToast();
    } else {
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              pageBuilder: (context, animation1, animation2) =>
                  SubjectSelectionScreen(
                      branchDetail: curruntBranch,
                      index: index,
                      seletedKey: seletedKey)));
    }
  }
}
