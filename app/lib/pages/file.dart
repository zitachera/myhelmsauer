import 'dart:io';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_render/pdf_render_widgets.dart';

class FilePage extends StatelessWidget {
  FilePage(this.portal, this.title, this.endpoint, {super.key});

  final PortalService portal;

  final String title;
  final String endpoint;

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: title,
      body: FutureBuilder<http.Response>(
        future: portal.getRessource(endpoint),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            var msg = snapshot.error.toString();
            if (snapshot.error is SocketException) {
              msg = "Keine Verbindung zum Server!";
            }
            return Column(
              children: [
                SizedBox(height: 5.0),
                Text(
                  msg,
                  style: TextStyle(color: helmsauerRot),
                ),
              ],
            );
          }
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final response = snapshot.data!;

          if (response.headers['content-type'] == 'application/pdf') {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: new AppBar(
                      title: Text(title),
                    ),
                    backgroundColor: Colors.grey,
                    body: PdfViewer.openData(response.bodyBytes),
                  ),
                ),
              ),
            );
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              SizedBox(height: 5.0),
              Text(
                "Für dieses Dokument ist keine Appansicht verfügbar.",
                style: TextStyle(color: helmsauerRot),
              ),
            ],
          );
        },
      ),
    );
  }
}
