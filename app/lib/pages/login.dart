import 'dart:io';

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<Portal> loader = Portal.restore();
  Key loaderKey = UniqueKey();

  String lastUserName = "";

  Future<Portal> login(String user, String password, String gruppe) async {
    final portal = Portal();
    await portal.login(user, password, gruppe);
    return portal;
  }

  _LoginForm get _form => _LoginForm(
        login: (user, password, gruppe) => setState(() {
          loader = login(user, password, gruppe);
          loaderKey = UniqueKey();
          lastUserName = user;
        }),
        lastUserName: lastUserName,
      );

  @override
  Widget build(BuildContext context) {
    return HsNestedScrollScaffold(
      title: "Helmsauer",
      key: loaderKey,
      body: FutureBuilder<Portal>(
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
                  style: TextStyle(color: helmsauerRed),
                ),
                _form,
              ],
            );
          }
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final portal = snapshot.data!;

          if (portal.loggedIn) {
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(portal),
                ),
              ),
            );
            return Center(child: CircularProgressIndicator());
          }

          return _form;
        },
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  _LoginForm({Key? key, required this.login, required this.lastUserName})
      : super(key: key);

  final _LoginFunc login;
  final String lastUserName;

  @override
  _LoginFormState createState() => _LoginFormState(login, lastUserName);
}

typedef _LoginFunc = void Function(String user, String password, String gruppe);

class _LoginFormState extends State<_LoginForm> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  String user = "";
  String password = "";
  String gruppe = defaultgruppe;
  static const defaultgruppe = "hk";

  final _LoginFunc login;

  _LoginFormState(this.login, this.user);

  DropdownMenuItem<String> _gruppeItem(String id, String name) =>
      DropdownMenuItem(
        child: Text(
          name,
          overflow: TextOverflow.ellipsis,
        ),
        value: id,
      );

  @override
  Widget build(BuildContext context) {
    final gruppeField = DropdownButton<String>(
      isExpanded: true,
      items: [
        _gruppeItem("hk", "Helmsauer Assekuranzmakler"),
        _gruppeItem("jade", "Jade Assekuranzmakler"),
        _gruppeItem("sue", "Schmidt & Erdsiek Assekuranzmakler"),
        _gruppeItem("bbg", "von Berenberg-Gossler Assekuranzmakler"),
        _gruppeItem("detmer", "Ärzte Wirtschaftszentrum Köln"),
        _gruppeItem("hp", "Helmsauer und Preuß"),
      ],
      value: gruppe,
      onChanged: (s) => setState(() => gruppe = s ?? defaultgruppe),
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

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => login(user, password, gruppe),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(36.0),
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
          loginButon,
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
