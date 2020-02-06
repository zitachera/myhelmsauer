import 'package:customer_portal_app/model/types.dart';
import 'package:flutter/material.dart';

class MeldungPage extends StatelessWidget {
  MeldungPage({Key key, this.meldung, this.vertrag}) : super(key: key);

  final Meldung meldung;
  final Vertrag vertrag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meldung.titel),
        bottom: PreferredSize(
            child: Container(
              color: Colors.red,
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(2.0)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _InfoLine(
                caption: "Vertrag",
                value: vertrag.name,
              ),
              _InfoLine(
                caption: "Datum",
                value: meldung.zeitpunkt.toString('dd.MM.yyyy'),
              ),
              _InfoLine(
                caption: "Uhrzeit",
                value: meldung.zeitpunkt.toString('HH:mm'),
              ),
              Text(
                "Beschreibung",
                textScaleFactor: 1.3,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  meldung.description,
                  textScaleFactor: 1.3,
                ),
              ),
            ],
          ),
        ),
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
            flex: 1,
          ),
          Expanded(
            child: Text(
              value,
              textScaleFactor: 1.3,
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
