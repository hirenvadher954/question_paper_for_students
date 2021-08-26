import 'package:flutter/material.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/BranchCard.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/GradientContainer.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/Quote.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/searchBar.dart';


class PaperSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
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
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      BranchCard(
                        branchName: "Diet Recommendations GradientContainer",
                      ),
                      BranchCard(
                        branchName: "Information Technology",
                      ),
                      BranchCard(branchName: "Civil Engineering")
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
