import 'dart:io';
import 'dart:typed_data';

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/pages/melden.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class VertragPage extends StatelessWidget {
  VertragPage({
    Key key,
    @required this.vertrag,
  }) : super(key: key);

  final Vertrag vertrag;

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Vertragsinfo',
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _InfoLine(
              caption: "Vertrag",
              value: vertrag.name,
            ),
            _InfoLine(
              caption: "Vertragsbeginn",
              value: vertrag.beginn.toString('dd.MM.yyyy'),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                vertrag.description,
                textScaleFactor: 1.3,
              ),
            ),
            FlatButton(
              onPressed: () async {
                var path = await prepareTestPdf();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HsPDFViewerScaffold(
                      pdfPath: path,
                      titel: vertrag.name,
                    ),
                  ),
                );
              },
              child: Text(
                "Vertragdetails Ansehen",
                textScaleFactor: 1.3,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Vorgang Melden'),
        icon: const Icon(Icons.add_to_photos),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeldenPage(
                vertrag: vertrag,
              ),
            ),
          ),
        },
      ),
    );
  }

  Future<String> prepareTestPdf() async {
    final ByteData bytes = await rootBundle.load("contract.pdf");
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/contract.pdf';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    Key key,
    this.caption,
    this.value,
  }) : super(key: key);

  final String caption;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              caption + ":",
              textScaleFactor: 1.3,
            ),
            flex: 2,
          ),
          Expanded(
            child: Text(
              value,
              textScaleFactor: 1.3,
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
