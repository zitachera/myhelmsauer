/*import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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
}*/

/*import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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

    // 🔹 FORMATTER €
    final euroFormatter = CurrencyTextInputFormatter(
      NumberFormat.currency(locale: 'fr_FR', symbol: '€'),
    );

    // 🔹 STYLE INPUT MODERNE (NOUVEAU)
    InputDecoration modernInput(String label) {
      return InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      );
    }

    final nameField = TextFormField(
      onChanged: (value) =>
          wertgegenstand = wertgegenstand.copyWith(name: value),
      initialValue: wertgegenstand.name,
      decoration: modernInput('Titel'), // 🔹 STYLE MODERNE
      validator: (value) =>
          value!.isEmpty ? 'Bitte geben Sie einen Titel ein.' : null,
    );

    final beschreibungField = TextFormField(
      onChanged: (value) =>
          wertgegenstand =
              wertgegenstand.copyWith(beschreibung: value),
      initialValue: wertgegenstand.beschreibung,
      maxLines: 5,
      decoration: modernInput('Beschreibung'), // 🔹 STYLE MODERNE
    );

    final wertField = TextFormField(
      onChanged: (value) => wertgegenstand =
          wertgegenstand.copyWith(
              wert: euroFormatter
                  .getUnformattedValue()
                  .toDouble()),
      initialValue:
          euroFormatter.formatDouble(wertgegenstand.wert),
      decoration: modernInput('Wert'), // 🔹 STYLE MODERNE
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[euroFormatter],
    );

    final content = Padding(
      padding: const EdgeInsets.all(20), // 🔹 PLUS D’AIR
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: <Widget>[

          // 🖼 IMAGE CARD MODERNE
          GestureDetector(
            onTap: showNewImageDialog,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(22), // 🔹 plus arrondi
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(22),
                child: AspectRatio(
                  aspectRatio: 1.66,
                  child: wertgegenstand
                          .image.isEmpty
                      ? Center(
                          child: Icon(
                            Icons
                                .add_photo_alternate_outlined,
                            size: 50,
                            color:
                                Colors.grey.shade400,
                          ),
                        )
                      : Image.memory(
                          wertgegenstand.image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          nameField,
          const SizedBox(height: 18),

          beschreibungField,
          const SizedBox(height: 18),

          wertField,
          const SizedBox(height: 30),

          // 🔹 BOUTON PRINCIPAL PREMIUM
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!
                  .validate()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Bitte geben Sie alle nötigen Daten an.'),
                  ),
                );
                return;
              }
              widget.saveWertgegenstand(
                  context, wertgegenstand);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  helmsauerBlau, // 🔹 bleu app
              foregroundColor: Colors.white,
              minimumSize:
                  const Size.fromHeight(60),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),
              elevation: 3,
            ),
            child: const Text(
              "Speichern",
              style: TextStyle(
                  fontWeight: FontWeight.w600),
            ),
          ),

          if (widget.deleteWertgegenstand !=
              null) ...[
            const SizedBox(height: 18),

            // 🔹 DELETE PLUS ÉLÉGANT
            OutlinedButton(
              onPressed: showDeleteDialog,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: helmsauerRot),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                          16),
                ),
                padding:
                    const EdgeInsets.symmetric(
                        vertical: 16),
              ),
              child: Text(
                "Löschen",
                style: TextStyle(
                  color: helmsauerRot,
                  fontWeight:
                      FontWeight.w600,
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

  /*void showNewImageDialog() {
    showDialog(
      context: context,
      builder: (context) => NewImageDialog(
        label: "Wertgegenstand",
        onAdd: (img) {
          setState(() {
            wertgegenstand =
                wertgegenstand.copyWith(
                    image: img);
          });
        },
      ),
    );*/

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // 🔹 MODERNE
        ),
        title: const Text(
            "Wertgegenstand löschen"),
        content: const Text(
            "Wollen Sie den Wertgegenstand wirklich löschen?"),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child:
                const Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.deleteWertgegenstand!(
                  context,
                  wertgegenstand);
            },
            child: Text(
              "Löschen",
              style: TextStyle(
                  color: helmsauerRot),
            ),
          ),
        ],
      ),
    );
  }
}*/

import 'dart:typed_data';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/wertgegenstand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // FORMAT € INPUT
    final euroFormatter = CurrencyTextInputFormatter(
      NumberFormat.currency(locale: 'fr_FR', symbol: '€'),
    );

    // MODERN INPUT STYLE
    InputDecoration modernInput(String label) {
      return InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      );
    }

    return HsSingleChildScrollScaffold(
      title: "Wertgegenstand",
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // IMAGE CARD
              GestureDetector(
                onTap: _showImagePickerSheet,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: AspectRatio(
                          aspectRatio: 1.66,
                          child: wertgegenstand.image.isEmpty
                              ? Center(
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 48,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              : Image.memory(
                                  wertgegenstand.image,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),

                    //  EDIT ICON
                    Positioned(
                      right: 14,
                      bottom: 14,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: helmsauerBlau,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // TITEL
              TextFormField(
                initialValue: wertgegenstand.name,
                decoration: modernInput("Titel"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Bitte Titel eingeben." : null,
                onChanged: (v) =>
                    wertgegenstand = wertgegenstand.copyWith(name: v),
              ),

              const SizedBox(height: 18),

              // BESCHREIBUNG
              TextFormField(
                initialValue: wertgegenstand.beschreibung,
                maxLines: 5,
                decoration: modernInput("Beschreibung"),
                onChanged: (v) =>
                    wertgegenstand = wertgegenstand.copyWith(beschreibung: v),
              ),

              const SizedBox(height: 18),

              //  WERT
              TextFormField(
                initialValue: euroFormatter.formatDouble(wertgegenstand.wert),
                decoration: modernInput("Wert"),
                keyboardType: TextInputType.number,
                inputFormatters: [euroFormatter],
                onChanged: (_) => wertgegenstand = wertgegenstand.copyWith(
                  wert: euroFormatter.getUnformattedValue().toDouble(),
                ),
              ),

              const SizedBox(height: 30),

              // SAVE
              FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Bitte geben Sie alle nötigen Daten an."),
                      ),
                    );
                    return;
                  }
                  widget.saveWertgegenstand(context, wertgegenstand);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: helmsauerBlau,
                  minimumSize: const Size.fromHeight(60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  "Speichern",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              if (widget.deleteWertgegenstand != null) ...[
                const SizedBox(height: 18),

                //  DELETE
                OutlinedButton(
                  onPressed: _showDeleteDialog,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: helmsauerRot),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Löschen",
                    style: TextStyle(
                      color: helmsauerRot,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  //  IMAGE PICKER BOTTOM SHEET
  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Foto hinzufügen",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: helmsauerBlau),
            ),
            const SizedBox(height: 20),
            _pickerButton(
              icon: Icons.photo_library_outlined,
              label: "Aus Galerie auswählen",
              source: ImageSource.gallery,
            ),
            const SizedBox(height: 12),
            _pickerButton(
              icon: Icons.camera_alt_outlined,
              label: "Foto aufnehmen",
              source: ImageSource.camera,
            ),
          ],
        ),
      ),
    );
  }

  Widget _pickerButton({
    required IconData icon,
    required String label,
    required ImageSource source,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () async {
        Navigator.pop(context);

        final XFile? image = await _picker.pickImage(
          source: source,
          maxWidth: 2048,
          maxHeight: 2048,
          imageQuality: 90,
        );

        if (image == null) return;

        final Uint8List bytes = await image.readAsBytes();
        setState(() {
          wertgegenstand = wertgegenstand.copyWith(image: bytes);
        });
      },
    );
  }

  //  DELETE CONFIRMATION
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("Wertgegenstand löschen"),
        content: const Text("Wollen Sie den Wertgegenstand wirklich löschen?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.deleteWertgegenstand!(context, wertgegenstand);
            },
            child: Text(
              "Löschen",
              style: TextStyle(color: helmsauerRot),
            ),
          ),
        ],
      ),
    );
  }
}
