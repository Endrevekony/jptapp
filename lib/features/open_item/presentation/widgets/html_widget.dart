import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlWidget extends StatelessWidget {
  final String html;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  HtmlWidget({Key key, @required this.html}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String contentBase64 =
    base64Encode(const Utf8Encoder().convert(html));
    return WebView(
      initialUrl: 'data:text/html;base64,$contentBase64',
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      gestureNavigationEnabled: true,
    );
  }
}