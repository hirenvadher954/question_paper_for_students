import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtu_question_paper/app/home/find_paper/bloc/find_paper_bloc.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/BranchCard.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/GradientContainer.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/Quote.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/searchBar.dart';
import 'package:gtu_question_paper/repository/find_paper/firebase_find_paper_repository.dart';

class PaperSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
          body: Stack(
            children: [
              GradientContainer(
                screenSize: 0.4,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Quote(textTheme: textTheme),
                    SearchBar(),
                    BlocBuilder<FindPaperBloc, FindPaperState>(
                      builder: (context, state) {
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
                        return Expanded(
                            child: GridView.builder(
                          itemCount: paperList.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0,
                                  childAspectRatio: 0.85),
                          itemBuilder: (context, index) {
                            var curruntBranch = paperList[index];
                            return BranchCard(
                              branchName: curruntBranch.branchName,
                              imgSrc: curruntBranch.imgSrc,
                            );
                          },
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
