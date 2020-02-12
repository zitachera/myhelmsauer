import 'dart:convert';
import 'dart:typed_data';

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/pages/images.dart';
import 'package:flutter/material.dart';

class VorfallPage extends StatelessWidget {
  VorfallPage({
    Key key,
    @required this.vorfall,
    @required this.vertrag,
  }) : super(key: key);

  final Vorfall vorfall;
  final Vertrag vertrag;

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: vorfall.titel,
      body: Column(
        children: <Widget>[
          _Line(
            caption: 'Vertrag',
            value: vertrag.name,
          ),
          _Line(
            caption: 'Datum',
            value: vorfall.zeitpunkt.toString('dd.MM.yyyy'),
          ),
          _Line(
            caption: 'Uhrzeit',
            value: vorfall.zeitpunkt.toString('HH:mm'),
          ),
          _Line(
            caption: 'Ort',
            value: vorfall.ort,
          ),
          _MultiLine(
            caption: 'Beschreibung',
            value: vorfall.description,
          ),
          PhotoCollection(
            images: _dataFromBase64Strings(vorfall.detailAufnahmen),
            label: "Detailansicht",
          ),
          PhotoCollection(
            images: _dataFromBase64Strings(vorfall.gesamtAufnahmen),
            label: "Gesamtansicht",
          ),
          PhotoCollection(
            images: _dataFromBase64Strings(vorfall.fahrzeugscheinAufnahmen),
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
    this.value,
  }) : super(key: key);

  final String caption;
  final String value;

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

List<Uint8List> _dataFromBase64Strings(List<String> base64String) =>
    base64String.map(base64Decode).toList();
