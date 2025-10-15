import 'dart:io';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/pages/news-ios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({
    super.key,
    required this.bottomNavigationBar,
    required this.onRefresh,
    required this.logout,
    required this.changePW,
  });

  final Widget bottomNavigationBar;
  final Future<void> Function() onRefresh;
  final void Function(BuildContext) logout;
  final void Function(BuildContext) changePW;

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  WebViewController? _controller;
  final String uri = 'https://www.helmsauer-gruppe.de/?headless=1';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!kIsWeb && !Platform.isIOS && _controller == null) {
      _initWebView();
    }
    // Note: WebView n'est pas supporté sur web Flutter
    // Sur web, nous utiliserons une alternative dans le build()
  }

  void _initWebView() {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
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

    if (mounted) {
      setState(() {
        _controller = controller;
      });
    }
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
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
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
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
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
        if (!kIsWeb && Platform.isIOS)
          const Expanded(child: IOSNews())
        else if (kIsWeb)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.web,
                    size: 64,
                    color: helmsauerRot,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Actualités Helmsauer',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cliquez sur le bouton ci-dessous pour accéder aux actualités',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      launchUrl(
                        Uri.parse(uri),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Ouvrir les actualités'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: helmsauerRot,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        else if (_controller != null)
          Expanded(child: WebViewWidget(controller: _controller!))
        else
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        title: Column(
          children: const [
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
