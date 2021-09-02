import 'package:flutter/material.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/GradientContainer.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/Quote.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/searchBar.dart';

class GradientSilverAppBar extends StatelessWidget {
  const GradientSilverAppBar({
    Key? key,
    required this.size,
    required this.textTheme,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        floating: false,
        pinned: false,
        expandedHeight: size.height * 0.4,
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size(0, 20),
        ),
        flexibleSpace: Stack(
          children: [
            GradientContainer(
              screenSize: 0.4,
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Quote(textTheme: textTheme),
                      SearchBar(margin: 60)
                    ])),
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
            ),
          ],
        ));
  }
}
