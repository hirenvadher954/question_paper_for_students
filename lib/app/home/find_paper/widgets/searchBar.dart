import 'package:flutter/material.dart';
import 'package:gtu_question_paper/app/home/search_question/SearchQuestion.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {this.margin = 30,
      required this.hintText,
      this.spacing = 0.01,
      this.fontSize = 13});

  final double margin;
  final String hintText;
  final double spacing;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => gotoSearchPage(context),
      child: Container(
        height: size.height * 0.06,
        margin: EdgeInsets.symmetric(vertical: margin),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(29.5),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 30,
            ),
            SizedBox(
              width: size.height * spacing,
            ),
            Text(
              hintText,
              style: TextStyle(fontSize: fontSize, color: Colors.grey),
            ),
          ],
        ),
        // child: TextField(
        //   decoration: InputDecoration(
        //     hintText: "Search Paper Questions",
        //     icon: Icon(
        //       Icons.search,
        //       size: 30,
        //     ),
        //     border: InputBorder.none,
        //     focusedBorder: InputBorder.none,
        //     enabledBorder: InputBorder.none,
        //   ),
        // ),
      ),
    );
  }

  gotoSearchPage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchQuestion()));
  }
}
