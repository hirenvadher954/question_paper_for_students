import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/app/home/detail_find_paper/widgets/sem_card.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/searchBar.dart';
import 'package:gtu_question_paper/app/home/paper_selection_screen/PaperSelectionScreen.dart';
import 'package:gtu_question_paper/repository/find_paper/models/FindPaper.dart';

import '../../../constants.dart';

class SubjectSelectionScreen extends StatefulWidget {
  const SubjectSelectionScreen(
      {required this.branchDetail,
      required this.index,
      required this.seletedKey});

  // final Map<String, dynamic> branchDetail;
  final FindPaper branchDetail;
  final int index;
  final String seletedKey;

  @override
  _SubjectSelectionScreenState createState() => _SubjectSelectionScreenState();
}

class _SubjectSelectionScreenState extends State<SubjectSelectionScreen> {
  List<String> subjectList = [];
  bool isLoading = true;
  bool isPageFirstTime = true;

  @override
  void initState() {
    super.initState();
    if (widget.seletedKey != "1&2") {
      subjectList = widget
          .branchDetail.semester[widget.seletedKey]["subjects"].keys
          .toList();
      isLoading = false;
    } else {
      loadFirstYearData();
    }
  }

  void loadFirstYearData() async {
    try {
      Future<DocumentSnapshot<Map<String, dynamic>>> firstYeaSnapshot =
          widget.branchDetail.semester[widget.seletedKey]["subjects"].get();
      firstYeaSnapshot.then((value) async {
        var firstYearData = value.data();
        subjectList = await firstYearData!["subjects"]!.keys.toList();
        widget.branchDetail.semester[widget.seletedKey]["subjects"] =
            await firstYearData["subjects"]!;
        setState(() {
          subjectList = subjectList;
          isLoading = false;
        });
      });
    } catch (e) {
      subjectList = widget
          .branchDetail.semester[widget.seletedKey]["subjects"].keys
          .toList();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SubjectSilverAppBar(
              size: size,
              textTheme: textTheme,
              branchDetail: widget.branchDetail,
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              _buildSubjectList(context, size, widget.branchDetail,
                  widget.index, widget.seletedKey),
            )),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSubjectList(context, Size size, FindPaper branchDetail,
      int index, String seletedKey) {
    List<Widget> listItems = [];
    listItems.add(Container(
      color: kLightBlueColor,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: _buildSubjectCardList(
                  context, branchDetail, index, seletedKey),
            ),
          ),
        ),
      ),
    ));
    return listItems;
  }

  List<Widget> _buildSubjectCardList(
      context, FindPaper branchDetail, index, String seletedKey) {
    List<Widget> listItems = [];
    subjectList.sort((a, b) => a.compareTo(b));
    for (int i = 0; i < subjectList.length; i++) {
      listItems.add(isLoading
          ? CircularProgressIndicator()
          : InkWell(
              onTap: () {
                print(branchDetail.semester[seletedKey]);
                navigateToPaperYearSelection(
                    context,
                    subjectList[i],
                    branchDetail.semester[seletedKey]["subjects"]
                        [subjectList[i]]);
              },
              child: AnimationConfiguration.staggeredGrid(
                position: i,
                columnCount: 2,
                duration: const Duration(milliseconds: 800),
                child: SlideAnimation(
                  child: SemCard(
                    screen: "subjectScreen",
                    cardTitle: subjectList[i],
                  ),
                ),
              ),
            ));
    }
    return listItems;
  }
}

void navigateToPaperYearSelection(
    context, subjectName, Map<String, dynamic> paperList) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaperSelectionScreen(
                subjectName: subjectName,
                paperList: paperList,
              )));
}

class SubjectSilverAppBar extends StatelessWidget {
  const SubjectSilverAppBar(
      {required this.size,
      required this.textTheme,
      required this.branchDetail});

  final Size size;
  final TextTheme textTheme;
  final FindPaper branchDetail;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: false,
      expandedHeight: size.height * 0.38,
      flexibleSpace: Stack(
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
                  left: -size.width * 0.22,
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
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Hero(
                      tag: branchDetail.semester,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          branchDetail.branchName,
                          style: GoogleFonts.oswald(
                              fontWeight: FontWeight.bold, fontSize: 35),
                          maxLines: 1,
                          // maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
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
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: kLightBlueColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green,
                  )
                ],
              ),
            ),
            bottom: -1,
            left: 0,
            right: 0,
          )
        ],
      ),
    );
  }
}
