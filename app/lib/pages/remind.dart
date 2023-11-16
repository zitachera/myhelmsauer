import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';

class RemindPage extends StatefulWidget {
  RemindPage({super.key});

  @override
  _RemindPageState createState() => _RemindPageState();
}

class _RemindPageState extends State<RemindPage> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  String nachname = "";
  String vorname = "";
  String adresse = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nachnameField = TextFormField(
      onChanged: (value) => nachname = value,
      style: style,
      initialValue: nachname,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Geben Sie Ihren Nachnamen an.';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Nachname",
      ),
    );

    final vornameField = TextFormField(
      onChanged: (value) => vorname = value,
      style: style,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Geben Sie Ihren Vornamen an.';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Vorname",
      ),
    );

    final adresseField = TextFormField(
      onChanged: (value) => adresse = value,
      style: style,
      maxLines: 4,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Geben Sie Ihre Adresse an.';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Adresse",
      ),
    );

    final remindButton = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5.0,
      color: helmsauerBlau,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
              PortalService.publicPost("remind", <String, String>{
                "nachname": nachname,
                "vorname": vorname,
                "adresse": adresse,
              }),
            );
          },
        );
      },
      child: Text(
        "Neues Passwort anfordern",
        textAlign: TextAlign.center,
        style: style.copyWith(color: Colors.white),
      ),
    );
    return HsSingleChildScrollScaffold(
      title: "Passwort vergessen",
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30.0),
              nachnameField,
              SizedBox(height: 25.0),
              vornameField,
              SizedBox(height: 35.0),
              adresseField,
              SizedBox(height: 25.0),
              Text(
                "Bitte beachten Sie, dass Ihre neuen Zugangsdaten auf dem postalischen Weg übermittelt werden.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 25.0),
              remindButton,
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendDialog extends StatelessWidget {
  const _SendDialog(this.future);

  final Future<void> future;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Passwortanfrage senden',
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

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    var nav = Navigator.of(context);
    if (snapshot.hasError) {
      return Column(
        children: [
          Text('Die Anfrage konnte nicht gesendet werden.', textScaler: TextScaler.linear(1.3)),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
                'Bitte versuchen Sie es in einigen Minuten erneut oder kontaktieren unseren Support.'),
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
        Text('Ihre Anfrage ist eingegangen.', textScaler: TextScaler.linear(1.3)),
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
