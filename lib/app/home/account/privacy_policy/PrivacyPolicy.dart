import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl:
          'https://talatiquestionpapers.blogspot.com/2021/09/privacy-policy.html',
    );
  }
}
