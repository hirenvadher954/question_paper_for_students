import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gtu_question_paper/app/home/detail_find_paper/DetailFindPaper.dart';
import 'package:gtu_question_paper/app/home/find_paper/bloc/find_paper_bloc.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/BranchCard.dart';
import 'package:gtu_question_paper/common_widgets/gradient_silver_app_bar.dart';
import 'package:gtu_question_paper/repository/find_paper/firebase_find_paper_repository.dart';

class PaperSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider<FindPaperBloc>(create: (context) {
          return FindPaperBloc(
              findpaperRepository: FirebaseFindPaperRepository())
            ..add(LoadFindPapers());
        })
      ],
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              GradientSilverAppBar(size: size, textTheme: textTheme),
              SliverList(
                  delegate: SliverChildListDelegate(_buildBrancList(size)))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBrancList(Size size) {
    List<Widget> listItems = [];
    listItems.add(
        BlocBuilder<FindPaperBloc, FindPaperState>(builder: (context, state) {
      if (state is! FindPaperLoaded) {
        return SizedBox(
          height: 100,
          width: 100,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      final paperList = state.paperList;
      return Container(
        color: Colors.lightBlue[100],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: size.height,
            child: Column(
              children: [
                Expanded(
                    child: GridView.builder(
                  itemCount: paperList.length,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 0.85),
                  itemBuilder: (context, index) {
                    var curruntBranch = paperList[index];
                    return InkWell(
                      onTap: () =>
                          _gotoDetailsFindPaper(context, curruntBranch),
                      child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 2,
                        duration: const Duration(milliseconds: 800),
                        child: SlideAnimation(
                          child: BranchCard(
                            branchName: curruntBranch.branchName,
                            imgSrc: curruntBranch.imgSrc,
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      );
    }));

    return listItems;
  }

  _gotoDetailsFindPaper(context, curruntBranch) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DetailFindPaper(branchDetail: curruntBranch)));
  }
}
