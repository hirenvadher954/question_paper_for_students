import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';

class PaperSelectionScreen extends StatefulWidget {
  const PaperSelectionScreen({Key? key}) : super(key: key);

  @override
  _PaperSelectionScreenState createState() => _PaperSelectionScreenState();
}

class _PaperSelectionScreenState extends State<PaperSelectionScreen> {
  int _count = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GridView"),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) {
                return <PopupMenuEntry<int>>[
                  ...[
                    1,
                    2,
                    3,
                    4,
                    5,
                  ]
                      .map((e) => PopupMenuItem<int>(
                            value: e,
                            child: Text("$e"),
                          ))
                      .toList(),
                ];
              },
              onSelected: (count) {
                setState(() {
                  _count = count;
                });
              },
            )
          ],
        ),
        body: Container(
          child: GridView.count(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            crossAxisCount: _count,
            children: WeatherType.values
                .map((e) => GridItemWidget(
                      weatherType: e,
                      count: _count,
                    ))
                .toList(),
          ),
        ));
  }
}

class GridItemWidget extends StatelessWidget {
  final WeatherType weatherType;
  final int count;

  GridItemWidget({Key? key, required this.weatherType, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var radius = 20.0 - 2 * count;
    var margin = 10.0 - count;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(margin),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))),
        child: Stack(
          children: [
            WeatherBg(
              weatherType: weatherType,
              width: MediaQuery.of(context).size.width / count,
              height: MediaQuery.of(context).size.width / 2,
            ),
            Center(
              child: Text(
                "2018",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30 / count,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}