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
              _buildSubjectList(context, size, branchDetail, 0),
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
  listItems.add(SingleChildScrollView(
    child: Container(
      color: Colors.lightBlue[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 20, runSpacing: 20, children: [
          SemCard(
            cardTitle: 'Java',
          ),
          SemCard(
            cardTitle: 'Test',
          ),
          SemCard(
            cardTitle: 'Test',
          )
        ]
            // _buildSubjectCardList(context, branchDetail, index),
            ),
      ),
    ),
  ));

  return listItems;
}

List<Widget> _buildSubjectCardList(context, FindPaper branchDetail, index) {
  List<Widget> listItems = [];
  for (int i = 0; i < branchDetail.semester.values.length; i++) {
    listItems.add(InkWell(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimationConfiguration.staggeredGrid(
          position: i,
          columnCount: 2,
          duration: const Duration(milliseconds: 800),
          child: SlideAnimation(
            child: SemCard(
              cardTitle: "abc",
            ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  AutoSizeText(
                    branchDetail.branchName,
                    style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold, fontSize: 35),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  SizedBox(
                    width: size.width * .55,
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
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
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
