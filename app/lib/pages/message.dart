/*import 'dart:typed_data';

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/components/images.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.portal});

  final PortalService portal;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<MessagePage> {
  _MessageState();

  List<Uint8List> aufnahmen = [];
  String text = "";

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Neue Nachricht',
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            PhotoCollectionField(
              images: aufnahmen,
              labelAdd: "Bild hinzufügen",
              label: "Bild",
              onDelete: (i) => setState(() => aufnahmen.removeAt(i)),
              onAdd: (image) => setState(() => aufnahmen.add(image)),
              max: 4,
            ),
            SizedBox(height: 10),
            TextFormField(
              autofocus: true,
              initialValue: text,
              minLines: 3,
              decoration: InputDecoration(
                hintText: "Bitte geben Sie Ihre Nachricht ein.",
              ),
              onChanged: (s) => text = s,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textAlignVertical: TextAlignVertical.bottom,
              validator: (value) => text.length > 5
                  ? null
                  : "Bitte geben Sie eine längere Nachricht ein.",
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

                await showDialog(
                  context: context,
                  builder: (BuildContext context) => _SendDialog(
                    sendMessage(),
                    key: UniqueKey(),
                  ),
                );
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              label: Text(
                'Senden',
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

  Future<void> sendMessage() async {
    final response = await widget.portal.postRessource(
      'message',
      {
        'text': text,
        'files': <String, Uint8List>{
          for (var i = 0; i < aufnahmen.length; i++)
            "Bild ${i + 1}": aufnahmen[i],
        },
      },
    );
    if (response.statusCode != 200) {
      throw "Senden der Nachricht fehlgeschlagen:${response.body}";
    }
  }
}

class _SendDialog extends StatelessWidget {
  const _SendDialog(
    this.future, {
    super.key,
  });

  final Future<void> future;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Nachricht senden',
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<void>(
            future: future,
            builder: builder,
          ),
        )
      ],
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot<void> snapshot) {
    var nav = Navigator.of(context);
    if (snapshot.hasError) {
      return Column(
        children: [
          Text('Der Bericht konnte nicht gesendet werden.',
              textScaler: TextScaler.linear(1.3)),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text('Bitte versuchen Sie es später erneut.'),
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
        Text('Ihre Nachricht ist bei uns eingegangen.',
            textScaler: TextScaler.linear(1.3)),
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
}*/

import 'dart:typed_data';

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/components/images.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.portal});

  final PortalService portal;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<MessagePage> {
  List<Uint8List> aufnahmen = [];
  String text = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Neue Nachricht',
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // UI: scroll moderne
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SECTION: BILDER

              _Card(
                title: "Anhänge",
                subtitle: "Fügen Sie Bilder zu Ihrer Nachricht hinzu",
                icon: Icons.photo_library_outlined,
                child: PhotoCollectionField(
                  images: aufnahmen,
                  labelAdd: "Bild hinzufügen",
                  label: "Bilder",
                  onDelete: (i) => setState(() => aufnahmen.removeAt(i)),
                  onAdd: (image) => setState(() => aufnahmen.add(image)),
                  max: 4,
                ),
              ),

              const SizedBox(height: 28),

              // SECTION: MESSAGE

              _Card(
                title: "Nachricht",
                subtitle: "Beschreiben Sie Ihr Anliegen",
                icon: Icons.chat_bubble_outline,
                child: TextFormField(
                  initialValue: text,
                  minLines: 5,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Bitte geben Sie Ihre Nachricht hier ein...",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.all(18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (s) => text = s,
                  validator: (_) => text.length > 5
                      ? null
                      : "Bitte geben Sie eine längere Nachricht ein.",
                ),
              ),

              const SizedBox(height: 36),

              // CTA: SENDEN

              SizedBox(
                height: 58,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text(
                    'Nachricht senden',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: _onSendPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  LOGIQUE ENVOI

  Future<void> _onSendPressed() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte geben Sie alle nötigen Daten an.'),
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) => _SendDialog(
        sendMessage(),
        key: UniqueKey(),
      ),
    );
  }

  Future<void> sendMessage() async {
    final response = await widget.portal.postRessource(
      'message',
      {
        'text': text,
        'files': <String, Uint8List>{
          for (var i = 0; i < aufnahmen.length; i++)
            "Bild ${i + 1}": aufnahmen[i],
        },
      },
    );
    if (response.statusCode != 200) {
      throw "Senden der Nachricht fehlgeschlagen:${response.body}";
    }
  }
}

// WIDGET UI RÉUTILISABLE — CARD MODERNE

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

//  DIALOG ENVOI (INCHANGÉ)

class _SendDialog extends StatelessWidget {
  const _SendDialog(this.future, {super.key});

  final Future<void> future;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Nachricht senden'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<void>(
            future: future,
            builder: builder,
          ),
        )
      ],
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot<void> snapshot) {
    var nav = Navigator.of(context);

    if (snapshot.hasError) {
      return Column(
        children: [
          const Text(
            'Der Bericht konnte nicht gesendet werden.',
            textScaler: TextScaler.linear(1.3),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4, bottom: 8),
            child: Text('Bitte versuchen Sie es später erneut.'),
          ),
          TextButton(
            onPressed: () => nav.pop(),
            child: const Text("Weiter"),
          ),
        ],
      );
    }

    if (snapshot.connectionState != ConnectionState.done) {
      return const Padding(
        padding: EdgeInsets.all(50),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Ihre Nachricht ist bei uns eingegangen.',
          textScaler: TextScaler.linear(1.3),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 4, bottom: 8),
          child: Text('Wir melden uns kurzfristig bei Ihnen.'),
        ),
        TextButton(
          onPressed: () => nav.popUntil((route) => route.isFirst),
          child: const Text("Abschließen"),
        ),
      ],
    );
  }
}
