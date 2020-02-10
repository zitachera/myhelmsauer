import 'dart:convert';
import 'dart:typed_data';

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/pages/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:time_machine/time_machine.dart';

class MeldenPage extends StatefulWidget {
  MeldenPage({Key key}) : super(key: key);

  @override
  _MeldenState createState() =>
      _MeldenState(datum: DateTime.now(), zeit: TimeOfDay.now());

  // set zeitpunkt(LocalDateTime ldt) {
  //   datum = DateTime(ldt.year, ldt.monthOfYear, ldt.dayOfMonth);
  //   zeit = TimeOfDay(hour: ldt.hourOfDay, minute: ldt.minuteOfHour);
  // }
}

class _MeldenState extends State<MeldenPage> {
  _MeldenState({this.datum, this.zeit});

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

  @override
  void initState() {
    super.initState();
    rootBundle.load('images/crash 1.png').then((data) {
      setState(() {
        var foto = data.buffer.asUint8List();
        detailAufnahmen = <Uint8List>[foto];
        gesamtAufnahmen = <Uint8List>[foto,foto,foto];
        fahrzeugscheinAufnahmen = <Uint8List>[foto];
      });
    });
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
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
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
                "Vertrag XY",
                textScaleFactor: 1.3,
              ),
            ),
            _Line(
              caption: 'Titel',
              child: TextFormField(
                initialValue: titel,
                onChanged: (s) => titel = s,
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
              child: FlatButton(
                child: Text(
                  "Coronastr 12, Nürnberg",
                  textScaleFactor: 1.3,
                ),
                onPressed: () => null,
              ),
            ),
            _MultiLine(
              caption: 'Beschreibung',
              child: TextField(
                controller: TextEditingController(
                  text:
                      "Lorem ipsum  diam nonumy eirmod tempor invidbergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            PhotoCollectionRow(
              images: detailAufnahmen,
              labelAdd: "Detailansicht hinzufügen",
              onDelete: (i) => setState(()=> detailAufnahmen.removeAt(i)),
              onAdd: (image) => setState(()=>  detailAufnahmen.add(image)),
              max: 3,
            ),
            PhotoCollectionRow(
              images: gesamtAufnahmen,
              labelAdd: "Gesamtansicht hinzufügen",
              max: 3,
            ),
            PhotoCollectionRow(
              images: fahrzeugscheinAufnahmen,
              labelAdd: "Fahrzeugscheinaufnahme hinzufügen",
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
      padding: EdgeInsets.all(10),
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
            child: child,
            flex: 2,
          ),
        ],
      ),
    );
  }
}

Uint8List _dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String _base64String(Uint8List data) {
  return base64Encode(data);
}
