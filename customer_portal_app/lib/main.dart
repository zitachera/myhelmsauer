import 'package:customer_portal_app/pages/home.dart';
import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helmsauer Versicherungen Portal',
      theme: ThemeData(
        primarySwatch: _createMaterialColor(helmsauerBlue),
        secondaryHeaderColor: _createMaterialColor(helmsauerRed),
        bottomAppBarColor: _createMaterialColor(helmsauerBlue),
      ),
      home: HomePage(),
    );
  }
}

MaterialColor _createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}