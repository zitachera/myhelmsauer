// DESIGN UPDATE Neues Passwort anfordern  modern, freundlich und klar

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';

class RemindPage extends StatefulWidget {
  const RemindPage({super.key});

  @override
  State<RemindPage> createState() => _RemindPageState();
}

class _RemindPageState extends State<RemindPage> {
  final _formKey = GlobalKey<FormState>();

  String nachname = "";
  String vorname = "";
  String adresse = "";

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: "Passwort vergessen",
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF5F7FA),
              Color(0xFFE4ECF7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 18,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// HEADER
                        Text(
                          "Neues Passwort anfordern",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: helmsauerBlau,
                              ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Bitte geben Sie Ihre persönlichen Daten ein. "
                          "Wir senden Ihnen Ihre neuen Zugangsdaten per Post zu.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(height: 1.5, color: Colors.black54),
                        ),

                        const SizedBox(height: 36),

                        /// NACHNAME
                        _ModernField(
                          label: "Nachname",
                          icon: Icons.person_outline,
                          validator: (v) => v == null || v.isEmpty
                              ? "Nachname erforderlich"
                              : null,
                          onChanged: (v) => nachname = v,
                        ),

                        const SizedBox(height: 20),

                        /// VORNAME
                        _ModernField(
                          label: "Vorname",
                          icon: Icons.person,
                          validator: (v) => v == null || v.isEmpty
                              ? "Vorname erforderlich"
                              : null,
                          onChanged: (v) => vorname = v,
                        ),

                        const SizedBox(height: 20),

                        /// ADRESSE
                        _ModernField(
                          label: "Adresse",
                          icon: Icons.home_outlined,
                          maxLines: 3,
                          validator: (v) => v == null || v.isEmpty
                              ? "Adresse erforderlich"
                              : null,
                          onChanged: (v) => adresse = v,
                        ),

                        const SizedBox(height: 30),

                        Text(
                          "Aus Sicherheitsgründen erfolgt der Versand ausschließlich postalisch.",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black45),
                        ),

                        const SizedBox(height: 36),

                        /// BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: helmsauerBlau,
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _submit,
                            child: const Text(
                              "Anfrage senden",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte alle Felder korrekt ausfüllen.")),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => _SendDialog(
        PortalService.publicPost("remind", {
          "nachname": nachname,
          "vorname": vorname,
          "adresse": adresse,
        }),
      ),
    );
  }
}

/// MODERN FIELD

class _ModernField extends StatelessWidget {
  const _ModernField({
    required this.label,
    required this.icon,
    required this.onChanged,
    required this.validator,
    this.maxLines = 1,
  });

  final String label;
  final IconData icon;
  final int maxLines;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: helmsauerBlau),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// DIALOG PREMIUM

class _SendDialog extends StatelessWidget {
  const _SendDialog(this.future);

  final Future<void> future;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<void>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.error_outline, color: Colors.red, size: 60),
                  SizedBox(height: 16),
                  Text(
                    "Die Anfrage konnte nicht gesendet werden.\nBitte später erneut versuchen.",
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check_circle_outline, color: Colors.green, size: 70),
                SizedBox(height: 16),
                Text(
                  "Ihre Anfrage wurde erfolgreich übermittelt.",
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';

class RemindPage extends StatefulWidget {
  const RemindPage({super.key});

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
          Text('Die Anfrage konnte nicht gesendet werden.',
              textScaler: TextScaler.linear(1.3)),
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
        Text('Ihre Anfrage ist eingegangen.',
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
}
*/

/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';

class RemindPage extends StatefulWidget {
  const RemindPage({super.key});

  @override
  State<RemindPage> createState() => _RemindPageState();
}

class _RemindPageState extends State<RemindPage> {
  final _formKey = GlobalKey<FormState>();

  String nachname = "";
  String vorname = "";
  String adresse = "";

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: "Passwort vergessen",
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 32, 28, 24), // ➜ plus d’air
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Titre épuré (plus petit, plus chic)
              Text(
                "Neues Passwort anfordern",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
              ),

              const SizedBox(height: 10),

              // 🔹 Texte secondaire discret
              Text(
                "Bitte geben Sie Ihre Daten ein, damit wir Ihnen ein neues Passwort zusenden können.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                      height: 1.4,
                    ),
              ),

              const SizedBox(height: 36),

              // 🔹 Champs minimalistes (nouveau style)
              _MinimalField(
                hint: "Nachname",
                validator: (v) =>
                    v == null || v.isEmpty ? "Nachname erforderlich" : null,
                onChanged: (v) => nachname = v,
              ),

              const SizedBox(height: 20),

              _MinimalField(
                hint: "Vorname",
                validator: (v) =>
                    v == null || v.isEmpty ? "Vorname erforderlich" : null,
                onChanged: (v) => vorname = v,
              ),

              const SizedBox(height: 20),

              _MinimalField(
                hint: "Adresse",
                maxLines: 3,
                validator: (v) =>
                    v == null || v.isEmpty ? "Adresse erforderlich" : null,
                onChanged: (v) => adresse = v,
              ),

              const SizedBox(height: 28),

              // 🔹 Note de sécurité (style premium)
              Text(
                "Ihre neuen Zugangsdaten werden Ihnen aus Sicherheitsgründen per Post zugesendet.",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black45,
                    ),
              ),

              const SizedBox(height: 36),

              // 🔹 Bouton principal chic
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: helmsauerBlau, // ➜ une seule couleur forte
                    elevation: 0, // ➜ plus moderne sans ombre lourde
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _submit,
                  child: const Text(
                    "Neues Passwort anfordern",
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
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

  // 🔹 Soumission (logique métier inchangée)
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte alle Felder ausfüllen.")),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => _SendDialog(
        PortalService.publicPost("remind", {
          "nachname": nachname,
          "vorname": vorname,
          "adresse": adresse,
        }),
      ),
    );
  }
}

// ===================================================================
// 🔹 CHAMP ULTRA MINIMALISTE – clé du design moderne
// ===================================================================
class _MinimalField extends StatelessWidget {
  const _MinimalField({
    required this.hint,
    required this.onChanged,
    required this.validator,
    this.maxLines = 1,
  });

  final String hint;
  final int maxLines;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38),

        // 🔹 Ligne fine en bas uniquement (très moderne)
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: helmsauerBlau),
        ),
      ),
    );
  }
}

// ===================================================================
// 🔹 Dialog résultat – simplifié et élégant
// ===================================================================
class _SendDialog extends StatelessWidget {
  const _SendDialog(this.future);

  final Future<void> future;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: FutureBuilder<void>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Die Anfrage konnte nicht gesendet werden. Bitte versuchen Sie es später erneut.",
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              height: 80,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return const Text(
            "Ihre Anfrage wurde erfolgreich übermittelt. Wir melden uns zeitnah bei Ihnen.",
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
          child: const Text("OK"),
        ),
      ],
    );
  }
}*/
