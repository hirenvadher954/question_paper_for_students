import 'package:flutter/material.dart';
import 'package:gtu_question_paper/constants.dart';

class SemCard extends StatelessWidget {
  const SemCard({required this.cardTitle});

  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth / 2 - 10,
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
            Text(
              cardTitle,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      );
    });
  }
}
