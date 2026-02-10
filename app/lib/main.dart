/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/pages/login.dart'; // Connexion désactivée
import 'package:customer_portal_app/pages/pages.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

// Gestion des certificats SSL pour les domaines Helmsauer
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Log pour débogage
        print('Vérification certificat SSL pour: $host:$port');
        print('Certificat sujet: ${cert.subject}');
        print('Certificat émetteur: ${cert.issuer}');

        // Accepter les certificats pour les domaines Helmsauer
        if (host.contains('helmsauer-gruppe.de') ||
            host.contains('192.168.35.40') ||
            host.contains('192.168.35.41')) {
          print('Certificat accepté pour $host');
          return true;
        }

        // Pour tous les autres domaines, utiliser la validation par défaut
        print('Certificat rejeté pour $host');
        return false;
      }
      ..connectionTimeout = const Duration(seconds: 30);

    return client;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Activer la gestion personnalisée des certificats SSL
  HttpOverrides.global = MyHttpOverrides();
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
      // Connexion désactivée - redirection directe vers la page d'accueil
       home: LoginPage(),
      home: Pages(PortalService(""))
           .home, // Token factice pour bypasser la connexion
      debugShowCheckedModeBanner: false,
    );
  }
}*/

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
  if (!kIsWeb && Platform.isWindows) {
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


import 'package:customer_portal_app/components/const.dart';
// import 'package:customer_portal_app/pages/login.dart'; // Connexion désactivée
import 'package:customer_portal_app/pages/pages.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

// Gestion des certificats SSL pour les domaines Helmsauer
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Log pour débogage
        print('Vérification certificat SSL pour: $host:$port');
        print('Certificat sujet: ${cert.subject}');
        print('Certificat émetteur: ${cert.issuer}');

        // Accepter les certificats pour les domaines Helmsauer
        if (host.contains('helmsauer-gruppe.de') ||
            host.contains('192.168.35.40') ||
            host.contains('192.168.35.41')) {
          print('Certificat accepté pour $host');
          return true;
        }

        // Pour tous les autres domaines, utiliser la validation par défaut
        print('Certificat rejeté pour $host');
        return false;
      }
      ..connectionTimeout = const Duration(seconds: 30);

    return client;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Activer la gestion personnalisée des certificats SSL
  HttpOverrides.global = MyHttpOverrides();
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
      // Connexion désactivée - redirection directe vers la page d'accueil
      // home: LoginPage(),
      home: Pages(PortalService(""))
          .home, // Token factice pour bypasser la connexion
      debugShowCheckedModeBanner: false,
    );
  }
}
