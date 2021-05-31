import 'dart:typed_data';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/portal.dart';
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
  MeldenPage({Key key, @required this.vertrag, @required this.portal})
      : super(key: key);

  final Vertrag vertrag;

  final Portal portal;

  @override
  _MeldenState createState() => _MeldenState(
        vertrag: vertrag,
        portal: portal,
        datum: DateTime.now(),
        zeit: TimeOfDay.now(),
      );
}

class _MeldenState extends State<MeldenPage> {
  _MeldenState({this.vertrag, this.portal, this.datum, this.zeit});

  final Vertrag vertrag;

  final Portal portal;

  DateTime get zeitpunkt => DateTime(
        datum.year,
        datum.month,
        datum.day,
        zeit.hour,
        zeit.minute,
        0,
      );

  String schadenhergang = "";
  String ort = "";
  Position gps;
  Map<String, List<Uint8List>> _aufnahmen = Map();

  DateTime datum;
  TimeOfDay zeit;

  Vorgang get vorgang => Vorgang(
        id: Uuid().v1(),
        vertragsID: vertrag.id,
        schadenhergang: schadenhergang,
        ort: ort,
        gps: gps,
        zeitpunkt: zeitpunkt,
        aufnahmen: _aufnahmen,
      );

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) => gps = position);
  }

  List<Widget> _aufnahmeFields() {
    List<Widget> cols = [];
    Row row;

    vertrag.aufnahmeKategorien.forEach((kat) {
      if (kat.max == 1) {
        if (row == null) {
          row = Row(
            children: [
              Expanded(
                flex: 1,
                child: _aufnahmeField(kat),
              ),
            ],
          );
          cols.add(row);
          return;
        }
        row.children.add(Expanded(
          flex: 1,
          child: _aufnahmeField(kat),
        ));
        row = null;
        return;
      }
      row = null;
      cols.add(_aufnahmeField(kat));
    });
    return cols;
  }

  PhotoCollectionField _aufnahmeField(VertragAufnahmeKategorie kategorie) {
    if (_aufnahmen[kategorie.id] == null) {
      _aufnahmen[kategorie.id] = <Uint8List>[];
    }
    return PhotoCollectionField(
      images: _aufnahmen[kategorie.id],
      labelAdd: "${kategorie.label} hinzufügen",
      label: kategorie.label,
      onDelete: (i) => setState(() => _aufnahmen[kategorie.id].removeAt(i)),
      onAdd: (image) => setState(() => _aufnahmen[kategorie.id].add(image)),
      infoAdd:
          kategorie.beschreibung != "" ? Text(kategorie.beschreibung) : null,
      max: kategorie.max,
    );
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
            ..._aufnahmeFields(),
            _Line(
              caption: 'Datum',
              child: MaterialButton(
                shape: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                child: Text(
                  dateFormat.format(zeitpunkt),
                  textScaleFactor: 1.3,
                ),
                onPressed: () => _selectDate(context),
              ),
            ),
            _Line(
              caption: 'Uhrzeit',
              child: MaterialButton(
                shape: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
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
                  ScaffoldMessenger.of(context).showSnackBar(
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
                try {
                  await portal.sendMeldung(vorgang);

                  await pr.hide();
                } catch (e) {
                  await pr.hide();

                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Der Bericht konnte nicht gesendet werden.',
                          textScaleFactor: 1.3,
                        ),
                        content:
                            Text('Bite senden Sie die Schadenmeldung erneut.'),
                        actions: [
                          MaterialButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Weiter"),
                          )
                        ],
                      );
                    },
                  );

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Der Bericht konnte nicht gesendet werden."),
                  ));
                  return;
                }

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Ihre Schadenmeldung ist eingegangen.',
                        textScaleFactor: 1.3,
                      ),
                      content: Text('Wir melden uns kurzfristig bei Ihnen.'),
                      actions: [
                        MaterialButton(
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
