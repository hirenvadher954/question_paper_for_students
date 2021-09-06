import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:gtu_question_paper/common_widgets/pdf_viewer_page.dart';
import 'package:gtu_question_paper/services/PDFApi.dart';

class PaperSelectionScreen extends StatefulWidget {
  const PaperSelectionScreen({Key? key}) : super(key: key);

  @override
  _PaperSelectionScreenState createState() => _PaperSelectionScreenState();
}

class _PaperSelectionScreenState extends State<PaperSelectionScreen> {
  int _count = 2;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Java"),
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3.5),
        ),
        itemBuilder: (BuildContext context, int index) {
          return ListItemWidget(
            weatherType: WeatherType.values[index],
          );
        },
        itemCount: WeatherType.values.length,
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final WeatherType weatherType;

  ListItemWidget({Key? key, required this.weatherType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _loadPdf(context),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                child: Text(
                  "2018",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
        ),
      ),
    );
  }

  void _loadPdf(context) async {
    final url =
        'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf';
    final file = await PDFApi.loadNetwork(url);
    openPDF(context, file);
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}
