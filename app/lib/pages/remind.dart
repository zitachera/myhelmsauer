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
  _RemindPageState createState() => _RemindPageState();
}

class _RemindPageState extends State<RemindPage> {
  /// 🔹 CHANGÉ : taille légèrement réduite pour mobile (plus moderne)
  final TextStyle style = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.0, // ⬅ avant 20 (trop gros sur mobile)
  );

  String nachname = "";
  String vorname = "";
  String adresse = "";

  final _formKey = GlobalKey<FormState>();

  /// 🔹 AJOUT : style commun pour les champs → design cohérent
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: helmsauerBlau), // icône moderne
      filled: true, // fond gris clair
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), // coins arrondis
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nachnameField = TextFormField(
      onChanged: (value) => nachname = value,
      style: style,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Geben Sie Ihren Nachnamen an.';
        }
        return null;
      },
      decoration: _inputDecoration(
        "Nachname",
        Icons.person_outline, // 🔹 AJOUT icône
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
      decoration: _inputDecoration(
        "Vorname",
        Icons.person, // 🔹 AJOUT icône
      ),
    );

    final adresseField = TextFormField(
      onChanged: (value) => adresse = value,
      style: style,
      maxLines: 3, // 🔹 CHANGÉ : plus compact que 4
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Geben Sie Ihre Adresse an.';
        }
        return null;
      },
      decoration: _inputDecoration(
        "Adresse",
        Icons.home_outlined, // 🔹 AJOUT icône
      ),
    );

    final remindButton = ElevatedButton.icon(
      /// 🔹 CHANGÉ : ElevatedButton → design moderne
      icon: const Icon(Icons.lock_reset),
      label: const Text("Neues Passwort anfordern"),
      style: ElevatedButton.styleFrom(
        backgroundColor: helmsauerBlau,
        foregroundColor: Colors.white,
        elevation: 4,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: style.copyWith(fontWeight: FontWeight.w600),
      ),
      onPressed: () async {
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
    );

    return HsSingleChildScrollScaffold(
      title: "Passwort vergessen",
      body: SingleChildScrollView(
        /// 🔹 AJOUT : évite overflow clavier
        padding: const EdgeInsets.all(24.0), // 🔹 CHANGÉ : plus aéré
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),

              /// 🔹 AJOUT : texte d’introduction UX
              Text(
                "Geben Sie bitte Ihre Daten ein, um ein neues Passwort anzufordern.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 30),
              nachnameField,
              const SizedBox(height: 16),
              vornameField,
              const SizedBox(height: 16),
              adresseField,
              const SizedBox(height: 24),

              /// 🔹 AMÉLIORÉ : texte explicatif plus lisible
              Text(
                "Ihre neuen Zugangsdaten werden Ihnen aus Sicherheitsgründen "
                "per Post zugesendet.",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade700),
              ),

              const SizedBox(height: 30),
              remindButton,
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===============================================================
/// 🔹 DIALOG D’ENVOI – DESIGN AMÉLIORÉ (LOGIQUE IDENTIQUE)
/// ===============================================================
class _SendDialog extends StatelessWidget {
  const _SendDialog(this.future);

  final Future<void> future;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      /// 🔹 CHANGÉ : AlertDialog → plus moderne que SimpleDialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text('Passwortanfrage senden'),
      content: FutureBuilder<void>(
        future: future,
        builder: builder,
      ),
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    final nav = Navigator.of(context);

    if (snapshot.hasError) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 12),
          const Text(
            'Die Anfrage konnte nicht gesendet werden.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Bitte versuchen Sie es später erneut oder kontaktieren Sie den Support.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => nav.pop(),
            child: const Text("Weiter"),
          ),
        ],
      );
    }

    if (snapshot.connectionState != ConnectionState.done) {
      return const Padding(
        padding: EdgeInsets.all(30),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 40),
        const SizedBox(height: 12),
        const Text(
          'Ihre Anfrage ist eingegangen.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Wir melden uns kurzfristig bei Ihnen.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => nav.popUntil((route) => route.isFirst),
          child: const Text("Abschließen"),
        ),
      ],
    );
  }
}*/

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
}
