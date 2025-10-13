import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

/*import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/pages/login.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_windows/webview_flutter_windows.dart'; // ✅ Import Windows WebView
// + tes autres imports existants (LoginPage, couleurs, etc.)*/

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
        //bottomAppBarTheme: BottomAppBarThemeData(color: helmsauerBlau),
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

/*class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'myHelmsauer',
      theme: ThemeData(
        primaryColor: helmsauerBlau,
        secondaryHeaderColor: helmsauerRot,
        bottomAppBarTheme: BottomAppBarThemeData(color: helmsauerBlau),
        primaryColorDark: dunklesBlau,
        fontFamily: "OpenSans",
        colorScheme: ColorScheme.fromSeed(
          seedColor: helmsauerBlau,
          brightness: Brightness.light,
          secondary: helmsauerRot,
        ),
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
          backgroundColor: helmsauerBlau,
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
}*/

/*class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
     ..badCertificateCallback = (X509Certificate cert, String host, int port) {
  return true;
};

  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Important pour WebView
  HttpOverrides.global = MyHttpOverrides();

  // ✅ Si l'app tourne sur Windows, on initialise la plateforme WebView correspondante
  if (Platform.isWindows) {
    WebViewPlatform.instance = WebViewWindowsPlatform();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'myHelmsauer',
      theme: ThemeData(
        primaryColor: helmsauerBlau,
        secondaryHeaderColor: helmsauerRot,
        bottomAppBarTheme: BottomAppBarThemeData(color: helmsauerBlau),
        primaryColorDark: dunklesBlau,
        fontFamily: "OpenSans",
        colorScheme: ColorScheme.fromSeed(
          seedColor: helmsauerBlau,
          brightness: Brightness.light,
          secondary: helmsauerRot,
        ),
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
          backgroundColor: helmsauerBlau,
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
}*/
