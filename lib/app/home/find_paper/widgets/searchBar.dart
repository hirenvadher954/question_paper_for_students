import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({this.margin = 30});
  final double margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          icon: Icon(
            Icons.search,
            size: 30,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
