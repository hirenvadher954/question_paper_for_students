import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:gtu_question_paper/common_widgets/pdf_viewer_page.dart';

enum SummerPaper {
  sunnyNight,
  sunny,
  cloudy,
  cloudyNight,
  overcast,
  hazy,
  foggy,
}
enum WinterPaper {
  heavyRainy,
  heavySnow,
  middleSnow,
  thunder,
  lightRainy,
  lightSnow,
  middleRainy
}

class PaperSelectionScreen extends StatelessWidget {
  PaperSelectionScreen({required this.paperList});

  final Map<String, dynamic> paperList;
  final int _count = 2;
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    int randomNumber = random.nextInt(6);
    print(randomNumber);
    print(paperList);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Java"),
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _count,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3.5),
        ),
        itemBuilder: (BuildContext context, int index) {
          return ListItemWidget(
              paperList: paperList, index: index, random: randomNumber);
        },
        itemCount: paperList.length,
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  ListItemWidget(
      {required this.paperList, required this.index, required this.random});

  final int index;
  final int random;
  final Map<String, dynamic> paperList;

  @override
  Widget build(BuildContext context) {
    String paperTitle = paperList.keys.toList()[index];
    print(WinterPaper.values.firstWhere((element) =>
        element.toString() == WeatherType.values[random].toString()));
    // weatherType = paperTitle.contains('winter')
    //     ? WeatherType.values.firstWhere(
    //         (e) => e.toString() == WinterPaper.values[random].toString())
    //     : WeatherType.values.firstWhere(
    //         (e) => e.toString() == SummerPaper.values[random].toString());
    final WeatherType weatherType = WeatherType.cloudy;
    return InkWell(
      onTap: () => _loadPdf(context, paperList[paperTitle]),
      child: AnimationConfiguration.staggeredGrid(
        position: index,
        columnCount: 2,
        duration: const Duration(milliseconds: 800),
        child: SlideAnimation(
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: ClipPath(
              child: Stack(
                children: [
                  WeatherBg(
                    weatherType: weatherType,
                    width: MediaQuery.of(context).size.width / 2,
                    height: 200,
                  ),
                  Container(
                    alignment: Alignment(-0.8, 0),
                    height: 100,
                    child: Center(
                      child: Text(
                        paperTitle.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ),
        ),
      ),
    );
  }

  void _loadPdf(context, url) async {
    openPDF(context, url);
  }

  void openPDF(BuildContext context, String url) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(url: url)),
      );
}
