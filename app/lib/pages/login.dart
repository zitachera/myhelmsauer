
//  DESIGN UPDATE : suppression AppBar + layout moderne avec gradient + card

import 'dart:io';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/model/firmen_gruppe.dart';
import 'package:customer_portal_app/pages/pages.dart';
import 'package:customer_portal_app/pages/remind.dart';
import 'package:customer_portal_app/service/session.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<LoginResult> loader = Session.restore();
  Key loaderKey = UniqueKey();

  String? lastGruppe;
  String lastUserName = "";

  _LoginForm get _form {
    return _LoginForm(
      login: (user, password, gruppe) => setState(() {
        loader = () async {
          if (gruppe == null) {
            return LoginResult(error: "Keine Firmengruppe ausgewählt!");
          }
          return await Session.login(user, password, gruppe);
        }();
        loaderKey = UniqueKey();
        lastGruppe = gruppe;
        lastUserName = user;
      }),
      lastGruppe: lastGruppe,
      lastUserName: lastUserName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: loaderKey,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 115, 205),
              Color(0xFF1565C0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<LoginResult>(
          future: loader,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _buildLayout(
                errorText: snapshot.error.toString(),
                child: _form,
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            }

            final result = snapshot.data!;

            if (result.error != null) {
              return _buildLayout(
                errorText: result.error!,
                child: _form,
              );
            }

            if (result.portal != null) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Pages(result.portal!).home,
                  ),
                ),
              );
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            }

            return _buildLayout(child: _form);
          },
        ),
      ),
    );
  }

  Widget _buildLayout({String? errorText, required Widget child}) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Card(
            elevation: 18,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// HEADER
                  Text(
                    "Willkommen bei",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade300,
                    ),
                  ),

                  const SizedBox(height: 8),

                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: const Text(
                      "MYHELMSAUER",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Color.fromARGB(255, 0, 115, 205),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (errorText != null) ...[
                    Text(
                      errorText,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],

                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef _LoginFunc = void Function(
    String user, String password, String? gruppe);

class _LoginForm extends StatefulWidget {
  const _LoginForm({
    required this.login,
    required this.lastGruppe,
    required this.lastUserName,
  });

  final _LoginFunc login;
  final String? lastGruppe;
  final String lastUserName;

  @override
  State<_LoginForm> createState() =>
      _LoginFormState(login, lastGruppe, lastUserName);
}

class _LoginFormState extends State<_LoginForm> {
  String user = "";
  String password = "";
  String? gruppe;

  bool obscure = true;

  final _LoginFunc login;

  _LoginFormState(this.login, this.gruppe, this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// FIRMGENGRUPPE
        DropdownButtonFormField<String>(
          value: gruppe,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: "Firmengruppe",
            prefixIcon: const Icon(Icons.business),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
          items: FirmenGruppe.all.map((fg) {
            return DropdownMenuItem<String>(
              value: fg.id,
              child: Text(
                fg.name,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) => setState(() => gruppe = value),
        ),

        const SizedBox(height: 20),

        /// USER
        TextFormField(
          initialValue: user,
          onChanged: (value) => user = value,
          decoration: InputDecoration(
            labelText: "User",
            prefixIcon: const Icon(Icons.person_outline),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// PASSWORD
        TextFormField(
          obscureText: obscure,
          onChanged: (value) => password = value,
          decoration: InputDecoration(
            labelText: "Passwort",
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () => setState(() => obscure = !obscure),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 30),

        /// LOGIN BUTTON
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: helmsauerBlau,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
            ),
            onPressed: () => login(user, password, gruppe),
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RemindPage()),
            );
          },
          child: const Text("Passwort vergessen?"),
        ),
      ],
    );
  }
}



/*import 'dart:io';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/model/firmen_gruppe.dart';
import 'package:customer_portal_app/pages/pages.dart';
import 'package:customer_portal_app/pages/remind.dart';
import 'package:customer_portal_app/service/session.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<LoginResult> loader = Session.restore();
  Key loaderKey = UniqueKey();

  String? lastGruppe;
  String lastUserName = "";

  _LoginForm get _form {
    return _LoginForm(
      login: (user, password, gruppe) => setState(() {
        loader = () async {
          if (gruppe == null) {
            return LoginResult(error: "Keine Firmengruppe ausgewählt!");
          }
          return await Session.login(user, password, gruppe);
        }();
        loaderKey = UniqueKey();
        lastGruppe = gruppe;
        lastUserName = user;
      }),
      lastGruppe: lastGruppe,
      lastUserName: lastUserName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = FutureBuilder<LoginResult>(
      future: loader,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          var msg = snapshot.error.toString();
          if (snapshot.error is SocketException) {
            // msg = 'CHICKEN';
            // TODO REVERT           msg = "Keine Verbindung zum Server!";
          }
          return Column(
            children: [
              SizedBox(height: 5.0),
              Text(
                msg,
                style: TextStyle(color: helmsauerRot),
              ),
              Expanded(child: _form),
            ],
          );
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final result = snapshot.data!;

        if (result.error != null) {
          return Column(
            children: [
              SizedBox(height: 5.0),
              Text(
                result.error!,
                style: TextStyle(color: helmsauerRot),
              ),
              Expanded(child: _form),
            ],
          );
        }

        if (result.portal != null) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Pages(result.portal!).home,
              ),
            ),
          );
          return Center(child: CircularProgressIndicator());
        }

        return _form;
      },
    );

    return Scaffold(
      key: loaderKey,
      appBar: AppBar(
        toolbarHeight: 110,
        title: Column(
          children: [
            Text(
              "Willkommen bei",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 24,
              ),
            ),
            Text(
              "MYHELMSAUER",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 36,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: body,
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm(
      {required this.login,
      required this.lastGruppe,
      required this.lastUserName});

  final _LoginFunc login;
  final String? lastGruppe;
  final String lastUserName;

  @override
  _LoginFormState createState() =>
      _LoginFormState(login, lastGruppe, lastUserName);
}

typedef _LoginFunc = void Function(
    String user, String password, String? gruppe);

class _LoginFormState extends State<_LoginForm> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  String user = "";
  String password = "";
  String? gruppe;

  final _LoginFunc login;

  _LoginFormState(this.login, this.gruppe, this.user);

  @override
  Widget build(BuildContext context) {
    final gruppeField = DropdownButton<String>(
      isExpanded: true,
      hint: Text("Bitte wählen Sie ihre Firmengruppe aus."),
      items: FirmenGruppe.all
          .map(
            (fg) => DropdownMenuItem(
              value: fg.id,
              child: Text(
                fg.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      value: gruppe,
      onChanged: (s) => setState(() => gruppe = s),
    );

    final userField = TextFormField(
      onChanged: (value) => user = value,
      style: style,
      initialValue: user,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "User",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordField = TextField(
      onChanged: (value) => password = value,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Passwort",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 5.0,
      color: helmsauerBlau,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () => login(user, password, gruppe),
      child: Text(
        "Login",
        textAlign: TextAlign.center,
        style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );

    // final demoButton = MaterialButton(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(30),
    //       topLeft: Radius.circular(30),
    //     ),
    //   ),
    //   color: Color.fromARGB(255, 241, 244, 247),
    //   elevation: 2.0,
    //   minWidth: MediaQuery.of(context).size.width,
    //   padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //   onPressed: () => login("maxmustermann", "ad45XV78?", "hk"),
    //   child: Text(
    //     "Demo",
    //     textAlign: TextAlign.center,
    //     style: style.copyWith(
    //       color: dunklesBlau,
    //       fontSize: 16,
    //     ),
    //     overflow: TextOverflow.ellipsis,
    //     maxLines: 1,
    //   ),
    // );

    final remind = MaterialButton(
      child: Text(
        "Passwort vergessen",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RemindPage()),
        ),
      },
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            gruppeField,
            SizedBox(height: 25.0),
            userField,
            SizedBox(height: 25.0),
            passwordField,
            SizedBox(height: 35.0),
            loginButton,
            // Row(
            //   children: [
            //     Expanded(
            //       child: demoButton,
            //       flex: 2,
            //     ),
            //     Expanded(
            //       child: loginButton,
            //       flex: 3,
            //     ),
            //   ],
            // ),
            SizedBox(height: 35.0),
            remind,
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}*/