import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: 'myHelmsauer',
      theme: ThemeData(
        primaryColor: helmsauerBlau,
        secondaryHeaderColor: helmsauerRot,
        bottomAppBarColor: helmsauerBlau,
        primaryColorDark: dunklesBlau,
        fontFamily: "OpenSans",
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 26,
            color: dunklesBlau,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(
            fontSize: 22,
            color: dunklesBlau,
            fontWeight: FontWeight.w500,
          ),
          bodyText1: TextStyle(
            fontSize: 18,
            color: dunklesBlau,
          ),
          button: TextStyle(
            fontSize: 18,
            color: dunklesBlau,
            fontWeight: FontWeight.w600,
          ),
        ),
        buttonTheme: ButtonThemeData(
          padding: EdgeInsets.all(5),
          textTheme: ButtonTextTheme.accent,
          colorScheme: Theme.of(context).colorScheme.copyWith(secondary: dunklesBlau),
        ),
        appBarTheme: AppBarTheme(
          color: helmsauerBlau,
          shape: UnderlineInputBorder(
            borderSide: BorderSide(color: helmsauerRot, width: 2.5),
          ),
        ),
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
