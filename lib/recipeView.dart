import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  String? url;
  RecipeView(this.url, {Key? key}) : super(key: key);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    String? newUrl;

    if (widget.url.toString().contains("http://")) {
      newUrl = widget.url.toString().replaceAll("http://", "https://");
      print(newUrl);
    } else {
      newUrl = widget.url;
      print(newUrl);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Web View"),
      ),
      body: WebView(
        initialUrl: newUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          setState(() {
            _controller.complete(webViewController);
          });
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
      ),
    );
  }
}
