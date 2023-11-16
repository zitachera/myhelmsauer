import 'dart:io';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/pages/news-ios.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  NewsPage({
    super.key,
    required this.bottomNavigationBar,
    required this.onRefresh,
    required this.logout,
    required this.changePW,
  });

  @override
  _NewsPageState createState() => _NewsPageState();

  final Widget bottomNavigationBar;

  final Future<void> Function() onRefresh;

  final void Function(BuildContext) logout;

  final void Function(BuildContext) changePW;
}

class _NewsPageState extends State<NewsPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    const uri = 'https://www.helmsauer-gruppe.de/?headless=1';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(uri) || !request.isMainFrame) {
              return NavigationDecision.navigate;
            }
            launchUrl(
              Uri.parse(request.url),
              mode: LaunchMode.externalApplication,
            );
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(uri));
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () => widget.changePW(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Passwort ändern"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () => widget.logout(context),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Log out",
                        style: TextStyle(
                          color: helmsauerRot,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.logout,
                      color: helmsauerRot,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (Platform.isIOS)
          Expanded(child: IOSNews())
        else
          Expanded(child: WebViewWidget(controller: _controller)),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        title: Column(
          children: [
            Text(
              "Willkommen bei",
              style: TextStyle(
                fontFamily: 'FuturaRound',
                fontWeight: FontWeight.w300,
                fontSize: 24,
              ),
            ),
            Text(
              "myHELMSAUER",
              style: TextStyle(
                fontFamily: 'FuturaRound',
                fontWeight: FontWeight.w500,
                fontSize: 36,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: content,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
