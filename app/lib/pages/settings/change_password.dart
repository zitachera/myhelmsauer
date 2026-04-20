/*import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
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
                if (val == null || val.isEmpty) {
                  return "Aktuelles Passwort benötigt";
                }
                return null;
              },
            ),
            TextFormField(
              controller: controllerNewPassword,
              decoration: InputDecoration(labelText: 'Neues Passwort'),
              obscureText: true,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Neues Passwort benötigt";
                }
                return null;
              },
            ),
            TextFormField(
              controller: controllerCheckPassword,
              decoration:
                  InputDecoration(labelText: 'Neues Passwort bestätigen'),
              obscureText: true,
              validator: (val) {
                if (val != controllerNewPassword.text) {
                  return "Passwort stimmt nicht überein";
                }
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
          Text('Fehler beim ändern des Passworts',
              textScaler: TextScaler.linear(1.3)),
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
} */

// NOUVEAU DESIGN

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    super.key,
    required this.portal,
  });

  final PortalService portal;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final controllerOldPassword = TextEditingController();
  final controllerNewPassword = TextEditingController();
  final controllerCheckPassword = TextEditingController();

  // DESIGN UPDATE : gestion visibilité password
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureCheck = true;

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: "Passwort ändern",
      body: Center(
        // DESIGN UPDATE : centrage
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: 500), //  largeur max moderne
          child: Card(
            elevation: 8, // ombre moderne
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), //  coins arrondis
            ),
            child: Padding(
              padding: const EdgeInsets.all(24), // padding augmenté
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //  TITRE MODERNE
                    /* Text(
                      "Sicherheit",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),*/
                    Text(
                      "Sicherheit",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 0, 115, 205),
                            letterSpacing: 0.4,
                          ),
                    ),
                    const SizedBox(height: 25),

                    //  CHAMP MOT DE PASSE ACTUEL
                    TextFormField(
                      controller: controllerOldPassword,
                      obscureText: _obscureOld,
                      decoration: InputDecoration(
                        labelText: 'Aktuelles Passwort',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureOld
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureOld = !_obscureOld;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Aktuelles Passwort benötigt";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    //  NOUVEAU MOT DE PASSE
                    TextFormField(
                      controller: controllerNewPassword,
                      obscureText: _obscureNew,
                      decoration: InputDecoration(
                        labelText: 'Neues Passwort',
                        prefixIcon: const Icon(Icons.lock_reset),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureNew
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureNew = !_obscureNew;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Neues Passwort benötigt";
                        }
                        if (val.length < 6) {
                          //  amélioration UX
                          return "Mindestens 6 Zeichen erforderlich";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    //  CONFIRMATION
                    TextFormField(
                      controller: controllerCheckPassword,
                      obscureText: _obscureCheck,
                      decoration: InputDecoration(
                        labelText: 'Neues Passwort bestätigen',
                        prefixIcon: const Icon(Icons.verified_user_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureCheck
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureCheck = !_obscureCheck;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (val) {
                        if (val != controllerNewPassword.text) {
                          return "Passwort stimmt nicht überein";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // BOUTON MODERNE FULL WIDTH
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Bitte geben Sie alle nötigen Daten an.'),
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
                        icon: const Icon(Icons.password),
                        label: const Text(
                          'Passwort ändern',
                          style: TextStyle(fontSize: 16),
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
    return Dialog(
      //  DESIGN UPDATE : Dialog moderne
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<void>(
          future: _send(),
          builder: (context, snapshot) {
            var nav = Navigator.of(context);

            if (snapshot.hasError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 15),
                  const Text(
                    'Fehler beim ändern des Passworts',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(snapshot.error.toString()),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => nav.pop(),
                    child: const Text("Weiter"),
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
              children: [
                const Icon(Icons.check_circle_outline,
                    color: Colors.green, size: 60),
                const SizedBox(height: 15),
                const Text(
                  'Ihr Passwort wurde geändert.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => nav.pop(),
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
