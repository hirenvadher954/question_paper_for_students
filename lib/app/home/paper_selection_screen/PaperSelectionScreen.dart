import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:gtu_question_paper/common_widgets/pdf_viewer_page.dart';

List<WeatherType> summerPaper = [
  WeatherType.sunnyNight,
  WeatherType.sunny,
  WeatherType.cloudy,
  WeatherType.cloudyNight,
  WeatherType.overcast,
];
List<WeatherType> winterPaper = [
  WeatherType.heavyRainy,
  WeatherType.heavySnow,
  WeatherType.middleSnow,
  WeatherType.thunder,
  WeatherType.lightRainy,
  WeatherType.lightSnow,
  WeatherType.middleRainy
];

class PaperSelectionScreen extends StatelessWidget {
  PaperSelectionScreen({required this.paperList, required this.subjectName});

  final String subjectName;
  final Map<String, dynamic> paperList;
  final int _count = 2;

  @override
  Widget build(BuildContext context) {
    print(paperList);
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _count,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3.5),
        ),
        itemBuilder: (BuildContext context, int index) {
          return ListItemWidget(paperList: paperList, index: index);
        },
        itemCount: paperList.length,
      ),
    );
  }
}

class ListItemWidget extends StatefulWidget {
  ListItemWidget({required this.paperList, required this.index});

  final int index;
  final Map<String, dynamic> paperList;

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    String paperTitle = widget.paperList.keys.toList()[widget.index];
    String year = paperTitle.toString().toUpperCase().split('-')[0];
    String season = paperTitle.toString().toUpperCase().split('-')[1];
    final WeatherType weatherType = paperTitle.contains('winter')
        ? winterPaper[random.nextInt(7)]
        : summerPaper[random.nextInt(5)];

    final Color color =
        paperTitle.contains('summer') ? Colors.deepOrangeAccent : Colors.yellow;
    return InkWell(
      onTap: () =>
          _loadPdf(context, widget.paperList[paperTitle], "$year - $season"),
      child: AnimationConfiguration.staggeredGrid(
        position: widget.index,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildColumnText(season, color),
                          buildColumnText(year, color),
                        ],
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

  Text buildColumnText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  void _loadPdf(context, url, title) async {
    openPDF(context, url, title);
  }

  void openPDF(BuildContext context, String url, String title) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(url: url, title: title)),
      );
}
