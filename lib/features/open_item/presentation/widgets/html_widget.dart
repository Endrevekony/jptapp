import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlWidget extends StatelessWidget {
  final String html;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  HtmlWidget({Key key, @required this.html}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl:
      'https://docs.google.com/gview?embedded=true&url=$html',
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
    );
  }
}