import 'package:flutter/material.dart';

class Quote extends StatelessWidget {
  const Quote({
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Good Morning \nHiren",
        style: textTheme.headline4?.copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}
