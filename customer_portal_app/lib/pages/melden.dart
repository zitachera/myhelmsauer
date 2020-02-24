import 'dart:typed_data';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/pages/images.dart';
import 'package:customer_portal_app/pages/vorgang.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:time_machine/time_machine.dart';
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

  // set zeitpunkt(LocalDateTime ldt) {
  //   datum = DateTime(ldt.year, ldt.monthOfYear, ldt.dayOfMonth);
  //   zeit = TimeOfDay(hour: ldt.hourOfDay, minute: ldt.minuteOfHour);
  // }
}

class _MeldenState extends State<MeldenPage> {
  _MeldenState({this.vertrag, this.datum, this.zeit});

  final Vertrag vertrag;

  String titel = "";
  LocalDateTime get zeitpunkt => LocalDateTime(
      datum.year, datum.month, datum.day, zeit.hour, zeit.minute, 0);

  String description = "";
  String ort = "";
  Position gps;
  List<Uint8List> detailAufnahmen = <Uint8List>[];
  List<Uint8List> gesamtAufnahmen = <Uint8List>[];
  List<Uint8List> fahrzeugscheinAufnahmen = <Uint8List>[];
  BearbeitungsStatus status;

  DateTime datum;
  TimeOfDay zeit;

  Vorgang get vorgang => Vorgang(
        id: Uuid().v1(),
        titel: titel,
        vertragsID: vertrag.id,
        description: description,
        ort: ort,
        gps: gps,
        detailAufnahmen: detailAufnahmen,
        gesamtAufnahmen: gesamtAufnahmen,
        fahrzeugscheinAufnahmen: fahrzeugscheinAufnahmen,
        status: status,
        zeitpunkt: zeitpunkt,
      );

  @override
  void initState() {
    super.initState();
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) => gps = position);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Vorgang Melden',
      actions: <Widget>[
        Builder(
          builder: (context) => FlatButton.icon(
            onPressed: () async {
              if (!_formKey.currentState.validate() ||
                  detailAufnahmen.length < 1 ||
                  gesamtAufnahmen.length < 1 ||
                  fahrzeugscheinAufnahmen.length < 1) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Bitte füllen Sie alle Felder aus und tragen mindestens ein Bild pro Kategorie ein.'),
                ));
                return;
              }
              setState(() => status = BearbeitungsStatus.wirdGesendet);
              var nav = Navigator.of(context);

              var pr = new ProgressDialog(context);
              pr.style(
                  message: 'Sende Vorgangsmeldung...',
                  borderRadius: 10.0,
                  backgroundColor: Colors.white,
                  progressWidget: SpinKitCircle(color: hemlsauerBlue),
                  elevation: 10.0,
                  insetAnimCurve: Curves.easeInOut,
                  messageTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600));

              await pr.show();

              // print(jsonEncode(vertrag.toJson()));
              // print(jsonEncode(vorgang.toJson()));

              await Future.delayed(Duration(seconds: 10));
              status = BearbeitungsStatus.inBearbeitung;

              await pr.hide();
              nav
                ..popUntil((route) => route.isFirst)
                ..push(
                  MaterialPageRoute(
                    builder: (context) => VorgangPage(
                      vorgang: vorgang,
                      vertrag: vertrag,
                    ),
                  ),
                );
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
                  return "Bitte geben Sie dem Vorgang einen Titel!";
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
                  return "Bitte geben Sie den Ort des Vorgangs an!";
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
                  return "Bitte beschreiben Sie den Vorgang!";
                },
              ),
            ),
            PhotoCollectionField(
              images: detailAufnahmen,
              labelAdd: "Detailansicht hinzufügen",
              label: 'Detailansicht',
              onDelete: (i) => setState(() => detailAufnahmen.removeAt(i)),
              onAdd: (image) => setState(() => detailAufnahmen.add(image)),
              infoAdd: Text(
                "hier können infos und text zur bildkategorie stehen.",
                maxLines: null,
              ),
              max: 3,
            ),
            PhotoCollectionField(
              images: gesamtAufnahmen,
              labelAdd: "Gesamtansicht hinzufügen",
              label: 'Gesamtansicht',
              onDelete: (i) => setState(() => gesamtAufnahmen.removeAt(i)),
              onAdd: (image) => setState(() => gesamtAufnahmen.add(image)),
              max: 3,
            ),
            PhotoCollectionField(
              images: fahrzeugscheinAufnahmen,
              labelAdd: "Fahrzeugscheinaufnahme hinzufügen",
              label: 'Fahrzeugscheinaufnahme',
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
