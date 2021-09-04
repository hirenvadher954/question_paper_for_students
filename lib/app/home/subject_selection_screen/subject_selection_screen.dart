import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/app/home/detail_find_paper/widgets/sem_card.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/searchBar.dart';
import 'package:gtu_question_paper/repository/find_paper/models/FindPaper.dart';

import '../../../constants.dart';

class SubjectSelectionScreen extends StatelessWidget {
  const SubjectSelectionScreen(
      {required this.branchDetail, required this.index});

  // final Map<String, dynamic> branchDetail;
  final FindPaper branchDetail;
  final int index;

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
              branchDetail: branchDetail,
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              _buildSubjectList(context, size, branchDetail, index),
            )),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildSubjectList(
    context, Size size, FindPaper branchDetail, int index) {
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
            children: _buildSubjectCardList(context, branchDetail, index),
          ),
        ),
      ),
    ),
  ));
  return listItems;
}

List<Widget> _buildSubjectCardList(context, FindPaper branchDetail, index) {
  final subjectCount =
      branchDetail.semester.values.elementAt(index)["subjects"].length;
  List<String> subjectList =
      branchDetail.semester.values.elementAt(index)["subjects"].keys.toList();
  List<Widget> listItems = [];
  for (int i = 0; i < subjectList.length; i++) {
    listItems.add(InkWell(
      onTap: () => {},
      child: AnimationConfiguration.staggeredGrid(
        position: i,
        columnCount: 2,
        duration: const Duration(milliseconds: 800),
        child: SlideAnimation(
          child: SemCard(
            cardTitle: subjectList[i],
          ),
        ),
      ),
    ));
  }
  return listItems;
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
                      tag: 'quoteText',
                      child: SizedBox(
                        width: size.width * .55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              "Quote must be small to read.",
                              // maxLines: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'serchBar',
                      child: SizedBox(
                        width: size.width * .5,
                        child: Material(
                            type: MaterialType.transparency, child: SearchBar()),
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
