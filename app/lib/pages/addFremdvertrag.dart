import 'dart:typed_data';

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/fremdvertragAntrag.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/components/images.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddFremdvertragPage extends StatefulWidget {
  AddFremdvertragPage({super.key, required this.portal});

  final PortalService portal;

  @override
  _AddFremdvertragState createState() => _AddFremdvertragState();
}

class _AddFremdvertragState extends State<AddFremdvertragPage> {
  _AddFremdvertragState();

  List<Uint8List> aufnahmen = [];
  Map<String, Uint8List> files = {};

  bool integrieren = false;
  bool vergleichsangebotErstellen = false;

  FremdvertragAntrag get fremdvertragAntrag => FremdvertragAntrag(
        aufnahmen: aufnahmen,
        files: files,
        integrieren: integrieren,
        vergleichsangebotErstellen: vergleichsangebotErstellen,
      );

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      PhotoCollectionField(
        images: aufnahmen,
        labelAdd: "Vertragsscan hinzufügen",
        label: "Vertragsscan",
        onDelete: (i) => setState(() => aufnahmen.removeAt(i)),
        onAdd: (image) => setState(() => aufnahmen.add(image)),
        // infoAdd: beschreibung,
        max: 6,
      ),
      Text(
        "Dateien:",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      for (var v in files.keys)
        Row(
          children: [
            Expanded(child: Text(v)),
            MaterialButton(
              child: Icon(Icons.delete),
              onPressed: () {
                setState(() => files.removeWhere((key, value) => key == v));
              },
            )
          ],
        ),
      Center(
        child: MaterialButton(
          child: Text("Datei auswählen"),
          onPressed: () => _pickFiles(context),
        ),
      ),
      Row(
        children: [
          Checkbox(
              value: integrieren,
              onChanged: (selected) => setState(() => integrieren = selected == true)),
          Expanded(
            child: Text("Vertrag in elektronische Kundenakte aufnehmen"),
          )
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Checkbox(
              value: vergleichsangebotErstellen,
              onChanged: (selected) =>
                  setState(() => vergleichsangebotErstellen = selected == true)),
          Expanded(
            child: Text("Bitte zusätzlich Vergleichsangebot erstellen"),
          )
        ],
      ),
      Center(
        child: ElevatedButton.icon(
          onPressed: () => send(context),
          icon: const Icon(
            Icons.send,
            color: Colors.white,
          ),
          label: Text(
            'Police speichern',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
    return HsSingleChildScrollScaffold(
      title: 'Fremdvertrag erfassen',
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children
              .map(
                (w) => Padding(
                  padding: EdgeInsets.all(8),
                  child: w,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void send(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bitte geben Sie alle nötigen Daten an.'),
        ),
      );
      return;
    }
    if (aufnahmen.isEmpty && files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bitte tragen mindestens ein Bild oder eine Datei ein.'),
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return _SendDialog(widget.portal, fremdvertragAntrag);
      },
    );
  }

  Future<void> _pickFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
    );

    if (result == null) return;

    setState(() {
      for (var file in result.files) {
        if (file.bytes != null) {
          files[file.name] = file.bytes!;
        }
      }
    });
  }
}

class _SendDialog extends StatelessWidget {
  const _SendDialog(this.portal, this.fremdvertragAntrag);

  final PortalService portal;
  final FremdvertragAntrag fremdvertragAntrag;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Fremdvertrag senden',
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<void>(
            future: portal.postRessource("fremdverträge", fremdvertragAntrag.toJson()),
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
          Text('Der Antrag konnte nicht gesendet werden.', textScaler: TextScaler.linear(1.3)),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text('Bitte senden Sie den Antrag erneut.'),
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
        Text('Ihre Antrag ist eingegangen.', textScaler: TextScaler.linear(1.3)),
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
