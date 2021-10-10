import 'package:flutter/material.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/GradientContainer.dart';
import 'package:gtu_question_paper/app/home/find_paper/widgets/searchBar.dart';
import 'package:gtu_question_paper/constants/ad_unit_id.dart';
import 'package:unity_ads_plugin/ad/unity_banner_ad.dart';
import 'package:unity_ads_plugin/unity_ads.dart';

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
  bool _showBanner = false;

  @override
  void initState() {
    // FacebookAudienceNetwork.init();
    super.initState();
    // loadBannerAd();
    UnityAds.init(
      gameId: '4399045',
      listener: (state, args) => print('Init Listener: $state => $args'),
    );
  }

  // void loadBannerAd() {
  //   setState(() {
  //     facebookBannerAd = FacebookBannerAd(
  //       placementId: AdUnitId.standardBannerId,
  //       bannerSize: BannerSize.STANDARD,
  //       listener: (result, val) {
  //         print(val);
  //         print(result);
  //       },
  //     );
  //   });
  // }

  // FacebookBannerAd? facebookBannerAd;

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
                      Center(
                        child: UnityBannerAd(
                          placementId: AdUnitId.unityBannerAd,
                          listener: (state, args) {
                            print('Banner Listener: $state => $args');
                          },
                        ),
                      ),
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
