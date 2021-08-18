import 'package:flutter/material.dart';

class GradientContainer extends StatefulWidget {
  const GradientContainer({Key? key, required this.screenSize})
      : super(key: key);
  final double screenSize;

  @override
  _GradientContainerState createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Colors.red;
  Color topColor = Colors.yellow;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        bottomColor = Colors.blue;
      });
    });
    return AnimatedContainer(
      height: size.height * widget.screenSize,
      duration: Duration(seconds: 2),
      onEnd: () {
        setState(() {
          index = index + 1;
          // animate the color
          bottomColor = colorList[index % colorList.length];
          topColor = colorList[(index + 1) % colorList.length];

          //// animate the alignment
          begin = alignmentList[index % alignmentList.length];
          end = alignmentList[(index + 2) % alignmentList.length];
        });
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: begin, end: end, colors: [bottomColor, topColor]),
      ),
    );
  }
}
