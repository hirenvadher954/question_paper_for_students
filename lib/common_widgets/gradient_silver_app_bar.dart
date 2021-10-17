import 'package:flutter/material.dart';
import 'package:flutter_applovin_max/banner.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/GradientContainer.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/searchBar.dart';
import 'package:gtu_question_paper/constants/ad_unit_id.dart';

import 'ads/applovin_banner_ads.dart';

class GradientSilverAppBar extends StatefulWidget {
  const GradientSilverAppBar({
    Key? key,
    required this.size,
    required this.textTheme,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;

  @override
  _GradientSilverAppBarState createState() => _GradientSilverAppBarState();
}

class _GradientSilverAppBarState extends State<GradientSilverAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        floating: false,
        pinned: false,
        expandedHeight: widget.size.height * 0.4,
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
                      // Quote(
                      //   fontSize: 28,
                      // ),
                      SearchBar(
                        margin: 60,
                        hintText: "Search Paper Solutions",
                        spacing: 0.02,
                        fontSize: 15,
                      ),
                      // Container(
                      //   child: facebookBannerAd,
                      // )
                      applovinBannerAd()
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
