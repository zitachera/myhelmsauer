import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({
    super.key,
    required this.portal,
  });

  final PortalService portal;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  _ChangePasswordState();

  final _formKey = GlobalKey<FormState>();

  final controllerOldPassword = TextEditingController();
  final controllerNewPassword = TextEditingController();
  final controllerCheckPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: "Passwort ändern",
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controllerOldPassword,
              decoration: InputDecoration(labelText: 'Aktuelles Passwort'),
              obscureText: true,
              validator: (val) {
                if (val == null || val.isEmpty) return "Aktuelles Passwort benötigt";
                return null;
              },
            ),
            TextFormField(
              controller: controllerNewPassword,
              decoration: InputDecoration(labelText: 'Neues Passwort'),
              obscureText: true,
              validator: (val) {
                if (val == null || val.isEmpty) return "Neues Passwort benötigt";
                return null;
              },
            ),
            TextFormField(
              controller: controllerCheckPassword,
              decoration: InputDecoration(labelText: 'Neues Passwort bestätigen'),
              obscureText: true,
              validator: (val) {
                if (val != controllerNewPassword.text) return "Passwort stimmt nicht überein";
                return null;
              },
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
                  builder: (BuildContext context) {
                    return _SendDialog(
                      portal: widget.portal,
                      oldPW: controllerOldPassword.text,
                      newPW: controllerNewPassword.text,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.password,
                color: Colors.white,
              ),
              label: Text(
                'Passwort ändern',
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
}

class _SendDialog extends StatelessWidget {
  const _SendDialog({
    required this.portal,
    required this.oldPW,
    required this.newPW,
  });

  final PortalService portal;
  final String oldPW;
  final String newPW;

  Future<void> _send() async {
    var response = await portal.postRessource('password', {
      "oldPassword": oldPW,
      "newPassword": newPW,
    });
    if (response.statusCode != 200) {
      throw (response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<void>(
            future: _send(),
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
          Text('Fehler beim ändern des Passworts', textScaler: TextScaler.linear(1.3)),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(snapshot.error.toString()),
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
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          child: Text('Ihr Passwort wurde geändert.'),
        ),
        MaterialButton(
          onPressed: () => nav.pop(),
          child: Text("Abschließen"),
        ),
      ],
    );
  }
}
