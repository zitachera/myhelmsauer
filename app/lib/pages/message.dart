import 'dart:typed_data';

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/components/images.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key, required this.portal});

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
              validator: (value) =>
                  text.length > 5 ? null : "Bitte geben Sie eine längere Nachricht ein.",
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

  sendMessage() async {
    final response = await widget.portal.postRessource(
      'message',
      {
        'text': text,
        'files': <String, Uint8List>{
          for (var i = 0; i < aufnahmen.length; i++) "Bild ${i + 1}": aufnahmen[i],
        },
      },
    );
    if (response.statusCode != 200) throw "Senden der Nachricht fehlgeschlagen:" + response.body;
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
          Text('Der Bericht konnte nicht gesendet werden.', textScaler: TextScaler.linear(1.3)),
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
        Text('Ihre Nachricht ist bei uns eingegangen.', textScaler: TextScaler.linear(1.3)),
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
