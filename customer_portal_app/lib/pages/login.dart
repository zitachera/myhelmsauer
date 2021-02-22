import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<Portal> loader = Portal.restore();

  @override
  Widget build(BuildContext context) {
    return HsNestedScrollScaffold(
      title: "Helmsauer",
      body: SingleChildScrollView(
        child: FutureBuilder<Portal>(
          future: Portal.restore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [
                  SizedBox(height: 5.0),
                  Text(
                    "${snapshot.error}",
                    style: TextStyle(color: helmsauerRed),
                  ),
                  _LoginForm(
                    onLogin: (l) => setState(() {
                      loader = l;
                      return null;
                    }),
                  ),
                ],
              );
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final portal = snapshot.data;

            if (portal.loggedIn) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(portal),
                  ),
                ),
              );
              return Center(child: CircularProgressIndicator());
            }

            return _LoginForm(
              onLogin: (l) => setState(() {
                loader = l;
                return null;
              }),
            );
          },
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  _LoginForm({Key key, @required this.onLogin}) : super(key: key);

  final ValueChanged<Future<Portal>> onLogin;

  @override
  _LoginFormState createState() => _LoginFormState(onLogin);
}

class _LoginFormState extends State<_LoginForm> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  String gruppe = "hk";
  String user = "";
  String password = "";

  final ValueChanged<Future<Portal>> onLogin;

  _LoginFormState(this.onLogin);

  DropdownMenuItem<String> _gruppeItem(String id, String name) =>
      DropdownMenuItem(
        child: Text(name),
        value: id,
      );

  @override
  Widget build(BuildContext context) {
    final gruppeField = DropdownButton(
      items: <DropdownMenuItem>[
        _gruppeItem("hk", "Helmsauer und Kollegen"),
        _gruppeItem("jade", "Jade"),
        _gruppeItem("sue", "Helmsauer und Kollegen"),
        _gruppeItem("bbg", "Helmsauer und Kollegen"),
        _gruppeItem("detmer", "Helmsauer und Kollegen"),
        _gruppeItem("hp", "Helmsauer und Kollegen"),
        _gruppeItem("luebcke", "Lübcke"),
      ],
      value: gruppe,
      onChanged: (s) => gruppe = s,
    );

    final userField = TextField(
      onChanged: (value) => user = value,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "User",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      onChanged: (value) => password = value,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Passwort",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => onLogin(_login()),
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
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

  Future<Portal> _login() async {
    final portal = Portal();
    await portal.login(user, password, gruppe);
    return portal;
  }
}
