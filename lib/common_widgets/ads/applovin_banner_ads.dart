import 'package:flutter_applovin_max/banner.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';
import 'package:gtu_question_paper/constants/ad_unit_id.dart';

BannerMaxView applovinBannerAd() {
  return BannerMaxView(
          (AppLovinAdListener? event) => print(event),
      BannerAdSize.banner,
      AdUnitId.applovinBannerId);
}