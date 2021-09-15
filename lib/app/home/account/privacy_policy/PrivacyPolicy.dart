import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String responseBody = "";

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    var url = Uri.parse(
        "https://talatiquestionpapers.blogspot.com/2021/09/privacy-policy.html");
    var response = await http.get(url);
    setState(() {
      responseBody = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: HtmlWidget(responseBody)),
    );
  }
}
