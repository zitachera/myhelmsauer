import 'dart:typed_data';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/pages/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class MeldenPage extends StatefulWidget {
  MeldenPage({Key key, @required this.vertrag}) : super(key: key);

  final Vertrag vertrag;

  @override
  _MeldenState createState() => _MeldenState(
        vertrag: vertrag,
        datum: DateTime.now(),
        zeit: TimeOfDay.now(),
      );

  // set zeitpunkt(DateTime ldt) {
  //   datum = DateTime(ldt.year, ldt.monthOfYear, ldt.dayOfMonth);
  //   zeit = TimeOfDay(hour: ldt.hourOfDay, minute: ldt.minuteOfHour);
  // }
}

class _MeldenState extends State<MeldenPage> {
  _MeldenState({this.vertrag, this.datum, this.zeit});

  final Vertrag vertrag;

  String titel = "";
  DateTime get zeitpunkt =>
      DateTime(datum.year, datum.month, datum.day, zeit.hour, zeit.minute, 0);

  String schadenhergang = "";
  String ort = "";
  Position gps;
  List<Uint8List> _ausweisFrontAufnahmen = <Uint8List>[];
  List<Uint8List> _ausweisBackAufnahmen = <Uint8List>[];
  List<Uint8List> _fuehrerscheinFrontAufnahmen = <Uint8List>[];
  List<Uint8List> _fuehrerscheinBackAufnahmen = <Uint8List>[];
  List<Uint8List> _grueneKarteAufnahmen = <Uint8List>[];
  List<Uint8List> _kennzeichenAufnahmen = <Uint8List>[];
  List<Uint8List> _unfallAufnahmen = <Uint8List>[];

  DateTime datum;
  TimeOfDay zeit;

  Vorgang get vorgang => Vorgang(
        id: Uuid().v1(),
        titel: titel,
        vertragsID: vertrag.id,
        schadenhergang: schadenhergang,
        ort: ort,
        gps: gps,
        zeitpunkt: zeitpunkt,
      );

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) => gps = position);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Schadenmeldung',
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PhotoCollectionField(
                    images: _ausweisFrontAufnahmen,
                    labelAdd: "Ausweis\u{00AD}vorderseite hinzufügen",
                    label: 'Ausweis\u{00AD}vorderseite',
                    onDelete: (i) =>
                        setState(() => _ausweisFrontAufnahmen.removeAt(i)),
                    onAdd: (image) =>
                        setState(() => _ausweisFrontAufnahmen.add(image)),
                    infoAdd: Text(
                      "hier können infos und text zur bildkategorie stehen.",
                      maxLines: null,
                    ),
                    max: 1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PhotoCollectionField(
                    images: _ausweisBackAufnahmen,
                    labelAdd: "Ausweis\u{00AD}rückseite hinzufügen",
                    label: 'Ausweis\u{00AD}rückseite',
                    onDelete: (i) =>
                        setState(() => _ausweisBackAufnahmen.removeAt(i)),
                    onAdd: (image) =>
                        setState(() => _ausweisBackAufnahmen.add(image)),
                    infoAdd: Text(
                      "hier können infos und text zur bildkategorie stehen.",
                      maxLines: null,
                    ),
                    max: 1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PhotoCollectionField(
                    images: _fuehrerscheinFrontAufnahmen,
                    labelAdd: "Führerschein\u{00AD}vorderseite hinzufügen",
                    label: 'Führerschein\u{00AD}vorderseite',
                    onDelete: (i) => setState(
                        () => _fuehrerscheinFrontAufnahmen.removeAt(i)),
                    onAdd: (image) =>
                        setState(() => _fuehrerscheinFrontAufnahmen.add(image)),
                    infoAdd: Text(
                      "hier können infos und text zur bildkategorie stehen.",
                      maxLines: null,
                    ),
                    max: 1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PhotoCollectionField(
                    images: _fuehrerscheinBackAufnahmen,
                    labelAdd: "Führerschein\u{00AD}rückseite hinzufügen",
                    label: 'Führerschein\u{00AD}rückseite',
                    onDelete: (i) =>
                        setState(() => _fuehrerscheinBackAufnahmen.removeAt(i)),
                    onAdd: (image) =>
                        setState(() => _fuehrerscheinBackAufnahmen.add(image)),
                    infoAdd: Text(
                      "hier können infos und text zur bildkategorie stehen.",
                      maxLines: null,
                    ),
                    max: 1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PhotoCollectionField(
                    images: _grueneKarteAufnahmen,
                    labelAdd: "Grüne Karte hinzufügen",
                    label: 'Grüne Karte',
                    onDelete: (i) =>
                        setState(() => _grueneKarteAufnahmen.removeAt(i)),
                    onAdd: (image) =>
                        setState(() => _grueneKarteAufnahmen.add(image)),
                    infoAdd: Text(
                      "hier können infos und text zur bildkategorie stehen.",
                      maxLines: null,
                    ),
                    max: 3,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PhotoCollectionField(
                    images: _kennzeichenAufnahmen,
                    labelAdd: "Gegnerisches Kennzeichen hinzufügen",
                    label: 'Gegnerisches Kennzeichen',
                    onDelete: (i) =>
                        setState(() => _kennzeichenAufnahmen.removeAt(i)),
                    onAdd: (image) =>
                        setState(() => _kennzeichenAufnahmen.add(image)),
                    infoAdd: Text(
                      "hier können infos und text zur bildkategorie stehen.",
                      maxLines: null,
                    ),
                    max: 3,
                  ),
                ),
              ],
            ),
            PhotoCollectionField(
              images: _unfallAufnahmen,
              labelAdd: "Unfall\u{00AD}aufnahme hinzufügen",
              label: 'Unfall\u{00AD}aufnahme',
              onDelete: (i) => setState(() => _unfallAufnahmen.removeAt(i)),
              onAdd: (image) => setState(() => _unfallAufnahmen.add(image)),
              infoAdd: Text(
                "hier können infos und text zur bildkategorie stehen.",
                maxLines: null,
              ),
              max: 3,
            ),
            _Line(
              caption: 'Datum',
              child: FlatButton(
                child: Text(
                  dateFormat.format(zeitpunkt),
                  textScaleFactor: 1.3,
                ),
                onPressed: () => _selectDate(context),
              ),
            ),
            _Line(
              caption: 'Uhrzeit',
              child: FlatButton(
                child: Text(
                  timeFormat.format(zeitpunkt),
                  textScaleFactor: 1.3,
                ),
                onPressed: () => _selectTime(context),
              ),
            ),
            _MultiLine(
              caption: 'Standort',
              child: TextFormField(
                initialValue: ort,
                onChanged: (s) => ort = s,
                validator: (s) {
                  if (s.isNotEmpty) return null;
                  return "Bitte geben Sie den Ort des Vorgangs an!";
                },
              ),
            ),
            _MultiLine(
              caption: 'Schadenhergang',
              child: TextFormField(
                initialValue: schadenhergang,
                onChanged: (s) => schadenhergang = s,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                if (!_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Bitte geben Sie alle nötigen Daten an.'),
                    ),
                  );
                  return;
                }
                // if (!_formKey.currentState.validate() ||
                //     _unfallAufnahmen.length < 1) {
                //   Scaffold.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text(
                //           'Bitte füllen Sie alle Felder aus und tragen mindestens ein Bild pro Kategorie ein.'),
                //     ),
                //   );
                //   return;
                // }
                var nav = Navigator.of(context);

                var pr = new ProgressDialog(context);
                pr.style(
                  message: 'Sende Schadenmeldung...',
                  borderRadius: 10.0,
                  backgroundColor: Colors.white,
                  progressWidget: SpinKitCircle(color: helmsauerBlue),
                  elevation: 10.0,
                  insetAnimCurve: Curves.easeInOut,
                  messageTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                );

                await pr.show();

                // print(jsonEncode(vertrag.toJson()));
                // print(jsonEncode(vorgang.toJson()));

                await Future.delayed(Duration(seconds: 3));

                await pr.hide();

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Ihre Schadenmeldung ist eingegangen.',
                        textScaleFactor: 1.3,
                      ),
                      content: Text(
                          'Wir werden uns in den kommenden Tagen mit Ihnen in Verbindung setzen.'),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Abschließen"),
                        )
                      ],
                    );
                  },
                );

                nav.popUntil((route) => route.isFirst);
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

  // _Line.text({
  //   Key key,
  //   this.caption,
  //   String value,
  // })  : child = Text(
  //         value,
  //         textScaleFactor: 1.3,
  //       ),
  //       super(key: key);

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
