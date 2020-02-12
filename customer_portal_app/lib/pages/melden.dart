import 'dart:convert';
import 'dart:typed_data';

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/pages/images.dart';
import 'package:customer_portal_app/pages/vorfall.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:time_machine/time_machine.dart';

class MeldenPage extends StatefulWidget {
  MeldenPage({Key key, @required this.vertrag}) : super(key: key);

  final Vertrag vertrag;

  @override
  _MeldenState createState() => _MeldenState(
        vertrag: vertrag,
        datum: DateTime.now(),
        zeit: TimeOfDay.now(),
      );

  // set zeitpunkt(LocalDateTime ldt) {
  //   datum = DateTime(ldt.year, ldt.monthOfYear, ldt.dayOfMonth);
  //   zeit = TimeOfDay(hour: ldt.hourOfDay, minute: ldt.minuteOfHour);
  // }
}

class _MeldenState extends State<MeldenPage> {
  _MeldenState({this.vertrag, this.datum, this.zeit});

  final Vertrag vertrag;

  String titel;
  LocalDateTime get zeitpunkt => LocalDateTime(
      datum.year, datum.month, datum.day, zeit.hour, zeit.minute, 0);

  String description;
  String ort;
  Position gps;
  List<Uint8List> detailAufnahmen = <Uint8List>[];
  List<Uint8List> gesamtAufnahmen = <Uint8List>[];
  List<Uint8List> fahrzeugscheinAufnahmen = <Uint8List>[];
  BearbeitungsStatus status;

  DateTime datum;
  TimeOfDay zeit;

  Vorfall get vorfall => Vorfall(
        titel: titel,
        description: description,
        ort: ort,
        gps: gps,
        detailAufnahmen: _base64Strings(detailAufnahmen),
        gesamtAufnahmen: _base64Strings(gesamtAufnahmen),
        fahrzeugscheinAufnahmen: _base64Strings(fahrzeugscheinAufnahmen),
        status: status,
        zeitpunkt: zeitpunkt,
      );

  @override
  void initState() {
    super.initState();
    rootBundle.load('images/crash 1.png').then((data) {
      setState(() {
        var foto = data.buffer.asUint8List();
        detailAufnahmen = <Uint8List>[foto];
        gesamtAufnahmen = <Uint8List>[foto, foto, foto];
        fahrzeugscheinAufnahmen = <Uint8List>[foto];
      });
    });
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) => gps = position);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Vorfall Melden',
      actions: <Widget>[
        Builder(
          builder: (context) => FlatButton.icon(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.of(context)
                  ..popUntil((route) => route.isFirst)
                  ..push(
                    MaterialPageRoute(
                      builder: (context) => VorfallPage(
                        vorfall: vorfall,
                        vertrag: vertrag,
                      ),
                    ),
                  );
              }
            },
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            label: Text(
              'Einreichen',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _Line(
              caption: "Vetrag",
              child: Text(
                vertrag.name,
                textScaleFactor: 1.3,
              ),
            ),
            _Line(
              caption: 'Titel',
              child: TextFormField(
                initialValue: titel,
                onChanged: (s) => titel = s,
                maxLength: 30,
                maxLengthEnforced: true,
                validator: (s) {
                  if (s.isNotEmpty) return null;
                  return "Bitte geben Sie dem Vorfall einen Titel!";
                },
              ),
            ),
            _Line(
              caption: 'Datum',
              child: FlatButton(
                child: Text(
                  zeitpunkt.toString('dd.MM.yyyy'),
                  textScaleFactor: 1.3,
                ),
                onPressed: () => _selectDate(context),
              ),
            ),
            _Line(
              caption: 'Uhrzeit',
              child: FlatButton(
                child: Text(
                  zeitpunkt.toString('HH:mm'),
                  textScaleFactor: 1.3,
                ),
                onPressed: () => _selectTime(context),
              ),
            ),
            _Line(
              caption: 'Ort',
              child: TextFormField(
                initialValue: ort,
                onChanged: (s) => ort = s,
                validator: (s) {
                  if (s.isNotEmpty) return null;
                  return "Bitte geben Sie den Ort des Vorfalls an!";
                },
              ),
            ),
            _MultiLine(
              caption: 'Beschreibung',
              child: TextFormField(
                initialValue: description,
                onChanged: (s) => description = s,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (s) {
                  if (s.isNotEmpty) return null;
                  return "Bitte beschreiben Sie den Vorfall!";
                },
              ),
            ),
            PhotoCollectionField(
              images: detailAufnahmen,
              labelAdd: "Detailansicht hinzufügen",
              onDelete: (i) => setState(() => detailAufnahmen.removeAt(i)),
              onAdd: (image) => setState(() => detailAufnahmen.add(image)),
              max: 3,
            ),
            PhotoCollectionField(
              images: gesamtAufnahmen,
              labelAdd: "Gesamtansicht hinzufügen",
              onDelete: (i) => setState(() => gesamtAufnahmen.removeAt(i)),
              onAdd: (image) => setState(() => gesamtAufnahmen.add(image)),
              max: 3,
            ),
            PhotoCollectionField(
              images: fahrzeugscheinAufnahmen,
              labelAdd: "Fahrzeugscheinaufnahme hinzufügen",
              onDelete: (i) =>
                  setState(() => fahrzeugscheinAufnahmen.removeAt(i)),
              onAdd: (image) =>
                  setState(() => fahrzeugscheinAufnahmen.add(image)),
              max: 2,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: datum,
      firstDate: DateTime(datum.year - 5),
      lastDate: datum,
    );
    if (picked != null && picked != datum) {
      setState(() {
        datum = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: zeit);
    if (picked != null && picked != zeit) {
      setState(() {
        zeit = picked;
      });
    }
  }
}

class _MultiLine extends StatelessWidget {
  const _MultiLine({
    Key key,
    this.caption,
    this.child,
  }) : super(key: key);

  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              caption + ":",
              textScaleFactor: 1.3,
            ),
          ),
          child,
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

  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
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

List<Uint8List> _dataFromBase64Strings(List<String> base64String) =>
    base64String.map(base64Decode).toList();

List<String> _base64Strings(List<Uint8List> data) =>
    data.map(base64Encode).toList();
