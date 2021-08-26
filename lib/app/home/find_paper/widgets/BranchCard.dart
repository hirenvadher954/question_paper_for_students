import 'package:flutter/material.dart';

class BranchCard extends StatelessWidget {
  BranchCard({required this.branchName});

  final String branchName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amberAccent, borderRadius: BorderRadius.circular(13)),
      child: Column(
        children: [
          Spacer(),
          FlutterLogo(
            size: 70,
          ),
          Spacer(),
          Padding(
            padding:  EdgeInsets.all(16.0),
            child: Text(
              branchName,
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
