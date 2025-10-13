import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/images.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/wertgegenstand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class WertgegenstandPage extends StatefulWidget {
  const WertgegenstandPage(
    this.wertgegenstand, {
    super.key,
    required this.saveWertgegenstand,
    this.deleteWertgegenstand,
  });

  final void Function(BuildContext, Wertgegenstand) saveWertgegenstand;
  final void Function(BuildContext, Wertgegenstand)? deleteWertgegenstand;
  final Wertgegenstand wertgegenstand;

  @override
  State<WertgegenstandPage> createState() =>
      _WertgegenstandPageState(wertgegenstand);
}

class _WertgegenstandPageState extends State<WertgegenstandPage> {
  Wertgegenstand wertgegenstand;

  _WertgegenstandPageState(this.wertgegenstand);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      onChanged: (value) =>
          wertgegenstand = wertgegenstand.copyWith(name: value),
      initialValue: wertgegenstand.name,
      decoration: InputDecoration(
        labelText: 'Titel',
      ),
      validator: (value) =>
          value!.isEmpty ? 'Bitte geben Sie einen Titel ein.' : null,
    );
    final beschreibungField = TextFormField(
      onChanged: (value) =>
          wertgegenstand = wertgegenstand.copyWith(beschreibung: value),
      initialValue: wertgegenstand.beschreibung,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Beschreibung',
      ),
    );

    /*final euroFormatter = CurrencyTextInputFormatter(
      locale: 'de_DE',
      symbol: '€',
      decimalDigits: 2,
    ); */
    final euroFormatter = CurrencyTextInputFormatter(
      NumberFormat.currency(locale: 'fr_FR', symbol: '€'),
    );

    final wertField = TextFormField(
      onChanged: (value) => wertgegenstand = wertgegenstand.copyWith(
          wert: euroFormatter.getUnformattedValue().toDouble()),
      initialValue: euroFormatter.formatDouble(wertgegenstand.wert),
      decoration: InputDecoration(
        labelText: 'Wert',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[euroFormatter],
    );

    final content = Container(
      margin: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: showNewImageDialog,
            child: Container(
              color: primaerGrau,
              child: wertgegenstand.image.isEmpty
                  ? FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: blauGrau,
                        ),
                      ),
                    )
                  : Image.memory(
                      wertgegenstand.image,
                      fit: BoxFit.fitWidth,
                    ),
            ),
          ),
          nameField,
          SizedBox(height: 4),
          beschreibungField,
          SizedBox(height: 4),
          wertField,
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Bitte geben Sie alle nötigen Daten an.'),
                  ),
                );
                return;
              }
              widget.saveWertgegenstand(context, wertgegenstand);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(60),
            ),
            child: Text("Speichern"),
          ),
          if (widget.deleteWertgegenstand != null) ...[
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => showDeleteDialog(),
              child: Text(
                "Löschen",
                style: TextStyle(
                  color: helmsauerRot,
                ),
              ),
            ),
          ],
        ],
      ),
    );
    return HsSingleChildScrollScaffold(
      title: "Wertgegenstand",
      body: Form(
        key: _formKey,
        child: content,
      ),
    );
  }

  void showNewImageDialog() {
    showDialog(
      context: context,
      builder: (context) => NewImageDialog(
        label: "Wertgegenstand",
        //info: Text("info"),
        onAdd: (img) {
          setState(() {
            wertgegenstand = wertgegenstand.copyWith(image: img);
          });
        },
      ),
    );
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Wertgegenstand löschen"),
        content: Text("Wollen Sie den Wertgegenstand wirklich löschen?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.deleteWertgegenstand!(context, wertgegenstand);
            },
            child: Text("Löschen"),
          ),
        ],
      ),
    );
  }
}
