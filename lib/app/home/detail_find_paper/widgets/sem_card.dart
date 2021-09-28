import 'package:flutter/material.dart';
import 'package:gtu_question_paper/constants.dart';

class SemCard extends StatelessWidget {
  const SemCard({required this.cardTitle, required this.screen});

  final String cardTitle;
  final String screen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: screen == "detailFindPaperScreen"
            ? constraint.maxWidth / 2 - 10
            : constraint.maxWidth,
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
            Flexible(
              child: Text(
                cardTitle,
                // style: Theme.of(context).textTheme.subtitle2,
                style: TextStyle(fontSize: 15.0),
                maxLines: 2,
              ),
            )
          ],
        ),
      );
    });
  }
}
