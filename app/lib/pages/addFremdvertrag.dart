/*import 'dart:typed_data';
import 'package:customer_portal_app/components/images.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/fremdvertragAntrag.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/components/const.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddFremdvertragPage extends StatefulWidget {
  const AddFremdvertragPage({super.key, required this.portal});

  final PortalService portal;

  @override
  State<AddFremdvertragPage> createState() => _AddFremdvertragState();
}

class _AddFremdvertragState extends State<AddFremdvertragPage> {
  List<Uint8List> aufnahmen = [];
  Map<String, Uint8List> files = {};

  bool integrieren = false;
  bool vergleichsangebotErstellen = false;

  final _formKey = GlobalKey<FormState>();

  FremdvertragAntrag get fremdvertragAntrag => FremdvertragAntrag(
        aufnahmen: aufnahmen,
        files: files,
        integrieren: integrieren,
        vergleichsangebotErstellen: vergleichsangebotErstellen,
      );

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: "Fremdvertrag erfassen",
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                _heroHeader(),
                const SizedBox(height: 24),
                _scanCard(),
                const SizedBox(height: 20),
                _fileCard(),
                const SizedBox(height: 20),
                _optionsCard(),
              ],
            ),
          ),

          // FLOATING ACTION
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: _submitButton(),
          ),
        ],
      ),
    );
  }

  Widget _heroHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
          ],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.assignment_outlined, color: Colors.white, size: 32),
          SizedBox(height: 12),
          Text(
            "Fremdvertrag hinzufügen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Scans oder Dokumente hochladen und Optionen festlegen.",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _scanCard() {
    return _glassCard(
      title: "Vertragsscans",
      icon: Icons.camera_alt_outlined,
      child: Column(
        children: [
          PhotoCollectionField(
            images: aufnahmen,
            label: "Scan",
            labelAdd: "Scan hinzufügen",
            max: 6,
            onAdd: (img) => setState(() => aufnahmen.add(img)),
            onDelete: (i) => setState(() => aufnahmen.removeAt(i)),
          ),
          if (aufnahmen.isEmpty) _hint("Fügen Sie Fotos des Vertrags hinzu."),
        ],
      ),
    );
  }

  Widget _fileCard() {
    return _glassCard(
      title: "Dokumente",
      icon: Icons.insert_drive_file_outlined,
      child: Column(
        children: [
          if (files.isEmpty) _hint("Keine Dateien hinzugefügt."),
          for (var name in files.keys)
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(name),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => files.remove(name)),
              ),
            ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text("Dateien auswählen"),
              onPressed: _pickFiles,
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionsCard() {
    return _glassCard(
      title: "Optionen",
      icon: Icons.tune_outlined,
      child: Column(
        children: [
          _optionTile(
            value: integrieren,
            title: "In elektronische Kundenakte aufnehmen",
            onChanged: (v) => setState(() => integrieren = v),
          ),
          _optionTile(
            value: vergleichsangebotErstellen,
            title: "Zusätzliches Vergleichsangebot erstellen",
            onChanged: (v) => setState(() => vergleichsangebotErstellen = v),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.send),
      label: const Text("Police speichern"),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () => send(context),
    );
  }

  Widget _glassCard(
      {required String title, required IconData icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _optionTile(
      {required bool value,
      required String title,
      required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _hint(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(text, style: TextStyle(color: Colors.grey.shade600)),
    );
  }

  void send(BuildContext context) async {
    if (aufnahmen.isEmpty && files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Bitte tragen mindestens ein Bild oder eine Datei ein.'),
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => _SendDialog(widget.portal, fremdvertragAntrag),
    );
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: true, withData: true);
    if (result == null) return;

    setState(() {
      for (var file in result.files) {
        if (file.bytes != null) files[file.name] = file.bytes!;
      }
    });
  }
}

// SEND DIALOG
class _SendDialog extends StatelessWidget {
  const _SendDialog(this.portal, this.antrag);

  final PortalService portal;
  final FremdvertragAntrag antrag;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<void>(
          future: portal.postRessource("fremdverträge", antrag.toJson()),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline,
                    size: 48, color: Colors.green),
                const SizedBox(height: 12),
                const Text("Antrag gesendet",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text("Wir melden uns kurzfristig bei Ihnen.",
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).popUntil((r) => r.isFirst),
                  child: const Text("Abschließen"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}*/
import 'dart:typed_data';
import 'package:customer_portal_app/components/images.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/fremdvertragAntrag.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddFremdvertragPage extends StatefulWidget {
  const AddFremdvertragPage({super.key, required this.portal});

  final PortalService portal;

  @override
  State<AddFremdvertragPage> createState() => _AddFremdvertragState();
}

class _AddFremdvertragState extends State<AddFremdvertragPage> {
  List<Uint8List> aufnahmen = [];
  Map<String, Uint8List> files = {};

  bool integrieren = false;
  bool vergleichsangebotErstellen = false;

  final _formKey = GlobalKey<FormState>();

  FremdvertragAntrag get fremdvertragAntrag => FremdvertragAntrag(
        aufnahmen: aufnahmen,
        files: files,
        integrieren: integrieren,
        vergleichsangebotErstellen: vergleichsangebotErstellen,
      );

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: "Fremdvertrag erfassen",
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                _heroHeader(),
                const SizedBox(height: 24),
                _scanCard(),
                const SizedBox(height: 20),
                _fileCard(),
                const SizedBox(height: 20),
                _optionsCard(),
              ],
            ),
          ),

          // FLOATING ACTION
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: _submitButton(),
          ),
        ],
      ),
    );
  }

  Widget _heroHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
          ],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.assignment_outlined, color: Colors.white, size: 32),
          SizedBox(height: 12),
          Text(
            "Fremdvertrag hinzufügen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Scans oder Dokumente hochladen und Optionen festlegen.",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _scanCard() {
    return _glassCard(
      title: "Vertragsscans",
      icon: Icons.camera_alt_outlined,
      child: Column(
        children: [
          PhotoCollectionField(
            images: aufnahmen,
            label: "Scan",
            labelAdd: "Scan hinzufügen",
            max: 6,
            onAdd: (img) => setState(() => aufnahmen.add(img)),
            onDelete: (i) => setState(() => aufnahmen.removeAt(i)),
          ),
          if (aufnahmen.isEmpty) _hint("Fügen Sie Fotos des Vertrags hinzu."),
        ],
      ),
    );
  }

  Widget _fileCard() {
    return _glassCard(
      title: "Dokumente",
      icon: Icons.insert_drive_file_outlined,
      child: Column(
        children: [
          if (files.isEmpty) _hint("Keine Dateien hinzugefügt."),
          for (var name in files.keys)
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(name),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => files.remove(name)),
              ),
            ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text("Dateien auswählen"),
              onPressed: _pickFiles,
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionsCard() {
    return _glassCard(
      title: "Optionen",
      icon: Icons.tune_outlined,
      child: Column(
        children: [
          _optionTile(
            value: integrieren,
            title: "In elektronische Kundenakte aufnehmen",
            onChanged: (v) => setState(() => integrieren = v),
          ),
          _optionTile(
            value: vergleichsangebotErstellen,
            title: "Zusätzliches Vergleichsangebot erstellen",
            onChanged: (v) => setState(() => vergleichsangebotErstellen = v),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.send),
      label: const Text("Police speichern"),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () => send(context),
    );
  }

  Widget _glassCard(
      {required String title, required IconData icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _optionTile(
      {required bool value,
      required String title,
      required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _hint(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(text, style: TextStyle(color: Colors.grey.shade600)),
    );
  }

  void send(BuildContext context) async {
    if (aufnahmen.isEmpty && files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Bitte tragen mindestens ein Bild oder eine Datei ein.'),
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => _SendDialog(widget.portal, fremdvertragAntrag),
    );
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: true, withData: true);
    if (result == null) return;

    setState(() {
      for (var file in result.files) {
        if (file.bytes != null) files[file.name] = file.bytes!;
      }
    });
  }
}

// SEND DIALOG
class _SendDialog extends StatelessWidget {
  const _SendDialog(this.portal, this.antrag);

  final PortalService portal;
  final FremdvertragAntrag antrag;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<void>(
          future: portal.postRessource("fremdverträge", antrag.toJson()),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline,
                    size: 48, color: Colors.green),
                const SizedBox(height: 12),
                const Text("Antrag gesendet",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text("Wir melden uns kurzfristig bei Ihnen.",
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).popUntil((r) => r.isFirst),
                  child: const Text("Abschließen"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


