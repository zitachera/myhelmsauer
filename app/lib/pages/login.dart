import 'dart:io';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/model/firmen_gruppe.dart';
import 'package:customer_portal_app/pages/pages.dart';
import 'package:customer_portal_app/pages/remind.dart';
import 'package:customer_portal_app/service/session.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

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
            msg = "Keine Verbindung zum Server!";
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
              "myHELMSAUER",
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
  _LoginForm({required this.login, required this.lastGruppe, required this.lastUserName});

  final _LoginFunc login;
  final String? lastGruppe;
  final String lastUserName;

  @override
  _LoginFormState createState() => _LoginFormState(login, lastGruppe, lastUserName);
}

typedef _LoginFunc = void Function(String user, String password, String? gruppe);

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
              child: Text(
                fg.name,
                overflow: TextOverflow.ellipsis,
              ),
              value: fg.id,
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
}
