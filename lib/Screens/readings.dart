// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ReadingScreen extends StatefulWidget {
  const ReadingScreen({
    Key? key,
    required this.link,
    this.function,
    required this.title,
    this.linked,
  }) : super(key: key);
  final String link, title;
  final Function()? function;
  final VoidCallback? linked;
  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  Completer<WebViewController> controller = Completer();
  var loadingPercentage = 0;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  void dispose() {
    widget.function!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: widget.title,
        actions: [
          IconButton(
            onPressed: widget.linked ?? () {},
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            zoomEnabled: false,
            initialUrl: widget.link,
            debuggingEnabled: true,
            onWebViewCreated: (val) {
              setState(() {
                if (!controller.isCompleted) controller.complete(val);
              });
            },
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
            navigationDelegate: (navigation) {
              final host = Uri.parse(navigation.url).host;
              print(host);
              return NavigationDecision.navigate;
            },
          ),
          if (loadingPercentage < 100)
            Center(
              child: LinearProgressIndicator(value: loadingPercentage / 100.0),
            ),
        ],
      ).marginOnly(left: 15, right: 15),
    );
  }
}
