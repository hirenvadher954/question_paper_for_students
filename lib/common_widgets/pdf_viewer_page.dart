import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerPage extends StatefulWidget {
  final String url;
  final String title;

  const PDFViewerPage({required this.url, required this.title});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PdfViewerController _pdfViewerController;
  late FToast fToast;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
    fToast = FToast();
    fToast.init(context);
    Future.delayed(Duration(seconds: 2), _showToast);
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: AutoSizeText(
        "It will take some time to load pdf because of slow internet connection",
        maxLines: 3,
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          color: Colors.black,
          child: SfPdfViewer.network(
            widget.url,
            controller: _pdfViewerController,
          ),
        ));
  }
}
