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
        bottomAppBarTheme: BottomAppBarTheme(color: helmsauerBlau),
        primaryColorDark: dunklesBlau,
        colorScheme: ColorScheme.fromSeed(
          seedColor: helmsauerBlau,
          brightness: Brightness.light,
          secondary: helmsauerRot,
        ),
        fontFamily: "OpenSans",
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 26,
            color: dunklesBlau,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            fontSize: 22,
            color: dunklesBlau,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: dunklesBlau,
          ),
          labelLarge: TextStyle(
            fontSize: 18,
            color: dunklesBlau,
            fontWeight: FontWeight.w600,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: helmsauerBlau,
          shape: UnderlineInputBorder(
            borderSide: BorderSide(color: helmsauerRot, width: 2.5),
          ),
          foregroundColor: Colors.white,
        ),
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
