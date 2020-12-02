import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/pages/images.dart';
import 'package:flutter/material.dart';

class VorgangPage extends StatelessWidget {
  VorgangPage({
    Key key,
    @required this.vorgang,
    @required this.vertrag,
  }) : super(key: key);

  final Vorgang vorgang;
  final Vertrag vertrag;

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: vorgang.titel,
      body: Column(
        children: <Widget>[
          _Line.text(
            caption: "Sparte",
            value: vertrag.sparte,
          ),
          _Line.text(
            caption: "Gesellschaft",
            value: vertrag.gesellschaft,
          ),
          _Line.text(
            caption: "Vertragsnummer",
            value: vertrag.vertragsnummer,
          ),
          _Line.text(
            caption: 'Datum',
            value: vorgang.zeitpunkt.toString('dd.MM.yyyy'),
          ),
          _Line.text(
            caption: 'Uhrzeit',
            value: vorgang.zeitpunkt.toString('HH:mm'),
          ),
          _Line.text(
            caption: 'Ort',
            value: vorgang.ort,
          ),
          _MultiLine(
            caption: 'Schadenhergang',
            value: vorgang.schadenhergang,
          ),
          PhotoCollection(
            images: vorgang.detailAufnahmen,
            label: "Detailansicht",
          ),
          PhotoCollection(
            images: vorgang.gesamtAufnahmen,
            label: "Gesamtansicht",
          ),
          PhotoCollection(
            images: vorgang.fahrzeugscheinAufnahmen,
            label: "Fahrzeugscheinaufnahme",
          ),
        ],
      ),
    );
  }
}

class _MultiLine extends StatelessWidget {
  const _MultiLine({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            caption + ":",
            textScaleFactor: 1.3,
          ),
          Text(
            value,
            textScaleFactor: 1.3,
            maxLines: null,
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    Key key,
    this.caption,
    this.child,
  }) : super(key: key);

  _Line.text({
    Key key,
    this.caption,
    String value,
  })  : child = Text(
          value,
          textScaleFactor: 1.3,
        ),
        super(key: key);

  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Expanded(
            child: Text(
              caption + ":",
              textScaleFactor: 1.3,
            ),
            flex: 1,
          ),
          Expanded(
            child: child,
            flex: 2,
          ),
        ],
      ),
    );
  }
}
