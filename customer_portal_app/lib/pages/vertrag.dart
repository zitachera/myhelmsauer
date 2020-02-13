import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/pages/melden.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeldenPage(
              vertrag: vertrag,
            )),
          ),
        },
        tooltip: 'Vorfall Melden',
        child: const Icon(Icons.add_to_photos),
      ),
    );
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
