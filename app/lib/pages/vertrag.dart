import 'dart:io';
import 'dart:typed_data';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vertrag.dart';
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
              caption: "Sparte",
              value: vertrag.sparte,
            ),
            _InfoLine(
              caption: "VSNR",
              value: vertrag.vertragsnummer,
            ),
            _InfoLine(
              caption: "Gesellschaft",
              value: vertrag.gesellschaft,
            ),
            _InfoLine(
              caption: "Ablauf",
              value: dateFormat.format(vertrag.ablauf),
            ),
            _InfoLine(
              caption: "Beitrag",
              value: vertrag.beitrag,
            ),
            _InfoLine(
              caption: "versichertes Risiko",
              value: vertrag.risiko,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: RaisedButton.icon(
            //     color: helmsauerBlue,
            //     textColor: Colors.white,
            //     padding: const EdgeInsets.all(20.0),
            //     label: Text(
            //       'Police',
            //       textScaleFactor: 1.8,
            //     ),
            //     icon: const Icon(Icons.text_snippet),
            //     onPressed: () async {
            //       var path = await prepareTestPdf();
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => HsPDFViewerScaffold(
            //             pdfPath: path,
            //             titel:
            //                 "${vertrag.sparte} ${vertrag.gesellschaft} ${vertrag.vertragsnummer}",
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<String> prepareTestPdf() async {
    final ByteData bytes = await rootBundle.load("images/KFZ.pdf");
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
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 250),
      ),
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
