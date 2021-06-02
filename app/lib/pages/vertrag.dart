import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/pages/file.dart';
import 'package:flutter/material.dart';

class VertragPage extends StatelessWidget {
  VertragPage(
    this.portal, {
    Key? key,
    required this.vertrag,
  }) : super(key: key);

  final Vertrag vertrag;

  final Portal portal;

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
            for (var dokument in vertrag.dokumente)
              MaterialButton(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.text_snippet),
                    ),
                    Expanded(
                      child: Text(
                        dokument.titel,
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FilePage(portal, dokument.titel, dokument.endpoint),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    Key? key,
    required this.caption,
    required this.value,
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
