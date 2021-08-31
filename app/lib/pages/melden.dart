import 'dart:typed_data';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/pages/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

class MeldenPage extends StatefulWidget {
  MeldenPage({Key? key, required this.vertrag, required this.portal})
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
  _MeldenState(
      {required this.vertrag,
      required this.portal,
      required this.datum,
      required this.zeit});

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
  Position? gps;
  Map<String, List<Uint8List>> aufnahmen = Map();
  Map<String, String> felder = Map();

  DateTime datum;
  TimeOfDay zeit;

  Vorgang get vorgang => Vorgang(
        id: Uuid().v1(),
        vertragsID: vertrag.id,
        schadenhergang: schadenhergang,
        ort: ort,
        latitude: gps?.latitude,
        longitude: gps?.longitude,
        zeitpunkt: zeitpunkt,
        aufnahmen: aufnahmen,
        felder: felder,
      );

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) => gps = position);
  }

  bool small(MeldeFeld f) => f.kind == MeldeFeldKind.images && f.max == 1;

  List<Widget> _aufnahmeFields(BuildContext context) {
    List<Widget> cols = [];
    Row? row;

    vertrag.meldeFelder.forEach((f) {
      if (!small(f)) {
        row = null;
        cols.add(buildField(context, f));
        return;
      }
      if (row == null) {
        row = Row(
          children: [
            Expanded(
              flex: 1,
              child: buildField(context, f),
            ),
          ],
        );
        cols.add(row!);
        return;
      }
      row!.children.add(Expanded(
        flex: 1,
        child: buildField(context, f),
      ));
      row = null;
    });
    return cols;
  }

  Widget buildField(BuildContext context, MeldeFeld f) {
    switch (f.kind) {
      case MeldeFeldKind.images:
        if (aufnahmen[f.id] == null) {
          aufnahmen[f.id] = <Uint8List>[];
        }
        return PhotoCollectionField(
          images: aufnahmen[f.id]!,
          labelAdd: "${f.label} hinzufügen",
          label: f.label,
          onDelete: (i) => setState(() => aufnahmen[f.id]!.removeAt(i)),
          onAdd: (image) => setState(() => aufnahmen[f.id]!.add(image)),
          infoAdd: f.beschreibung != "" ? Text(f.beschreibung) : null,
          max: f.max,
        );
      case MeldeFeldKind.textfield:
        return _Line(
          caption: f.label,
          child: TextFormField(
            initialValue: felder[f.id] ?? "",
            onChanged: (s) => felder[f.id] = s,
            decoration: InputDecoration(hintText: f.beschreibung),
          ),
        );
      case MeldeFeldKind.section:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child:
                  Text(f.label, style: Theme.of(context).textTheme.headline2),
            ),
            if (f.beschreibung != "")
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Text(f.beschreibung,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
          ],
        );
      case MeldeFeldKind.choice:
        if (felder[f.id] != "ja") felder[f.id] = "nein";
        return _InvertedLine(
          child: Checkbox(
              value: felder[f.id] == "ja",
              onChanged: (selected) => setState(
                  () => felder[f.id] = selected == true ? "ja" : "nein")),
          caption: f.label,
        );
    }
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
            ..._aufnahmeFields(context),
            _Line(
              caption: 'Datum',
              child: MaterialButton(
                shape: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                child: Text(
                  dateFormat.format(zeitpunkt),
                  style: Theme.of(context).textTheme.bodyText1,
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
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onPressed: () => _selectTime(context),
              ),
            ),
            _MultiLine(
              caption: 'Unfallort',
              child: TextFormField(
                initialValue: ort,
                onChanged: (s) => ort = s,
                validator: (s) {
                  if (s!.isNotEmpty) return null;
                  return "Bitte geben Sie den Ort des Unfalls an!";
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
                if (!_formKey.currentState!.validate()) {
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

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _SendDialog(portal, vorgang);
                  },
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
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
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
    final TimeOfDay? picked =
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
    Key? key,
    required this.caption,
    required this.child,
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
              style: Theme.of(context).textTheme.bodyText1,
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
    Key? key,
    required this.caption,
    required this.child,
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
              style: Theme.of(context).textTheme.bodyText1,
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

class _InvertedLine extends StatelessWidget {
  const _InvertedLine({
    Key? key,
    required this.caption,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Expanded(
            child: child,
            flex: 1,
          ),
          Expanded(
            child: Text(
              caption,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class _SendDialog extends StatelessWidget {
  const _SendDialog(
    this.portal,
    this.vorgang, {
    Key? key,
  }) : super(key: key);

  final Portal portal;
  final Vorgang vorgang;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Schadenmeldung senden',
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<void>(
            future: portal.sendMeldung(vorgang),
            builder: builder,
          ),
        )
      ],
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    var nav = Navigator.of(context);
    if (snapshot.hasError) {
      return Column(
        children: [
          Text(
            'Der Bericht konnte nicht gesendet werden.',
            textScaleFactor: 1.3,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text('Bite senden Sie die Schadenmeldung erneut.'),
          ),
          MaterialButton(
            onPressed: () => nav.pop(),
            child: Text("Weiter"),
          ),
        ],
      );
    }
    if (snapshot.connectionState != ConnectionState.done) {
      return Padding(
        padding: const EdgeInsets.all(50),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Ihre Schadenmeldung ist eingegangen.',
          textScaleFactor: 1.3,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          child: Text('Wir melden uns kurzfristig bei Ihnen.'),
        ),
        MaterialButton(
          onPressed: () => nav.popUntil((route) => route.isFirst),
          child: Text("Abschließen"),
        ),
      ],
    );
  }
}
