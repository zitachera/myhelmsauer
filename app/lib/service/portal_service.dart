import 'dart:convert';
import 'dart:io';

import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class PortalService {
  PortalService(this._token);

  final String _token;

  // Uri _uri(String resource) => Uri.http("10.0.2.2:8080", 'api/v1/' + resource); // debug pc

  static const bool isProd = bool.fromEnvironment("dart.vm.product");

  //static /Uri _uri(String resource) => Uri.https(
  // !isProd{

  // return Uri.https("testschadenmeldung.helmsauer-gruppe.de", 'api/v1/$resource');
  // } else {
  // return Uri.http("172.18.48.242:8080", 'api/v1/$resource');

// Dynamische URI je nach Umgebung
  static Uri _uri(String resource) {
    if (isProd) {
      return Uri.https(
          //"schadenmeldung.helmsauer-gruppe.de"
          "testschadenmeldung.helmsauer-gruppe.de",
          '/api/v1/$resource');
    } else {
      // En développement : utiliser 10.0.2.2 pour l'émulateur Android, localhost pour les autres plateformes
      final String host;
      if (!kIsWeb && Platform.isAndroid) {
        // L'émulateur Android utilise 10.0.2.2 pour accéder à localhost de la machine hôte
        host = "10.0.2.2:8080";
      } else {
        // Pour web, desktop, iOS, etc. utiliser localhost
        host = "localhost:8080";
      }
      return Uri.http(host, '/api/v1/$resource');
    }
  }
  // ? "schadenmeldung.helmsauer-gruppe.de"
  // : "testschadenmeldung.helmsauer-gruppe.de",
  //'api/v1/' + resource);*/
  //Uri _uri(String resource) =>
  //Uri.http("10.0.2.2:8080", 'api/v1/$resource');

  //static Uri _uri(String resource) =>

  // http.post("172.18.48.242:8080", 'api/v1/$resource');

  static Future<http.Response> publicPost(String ressource, Object content) =>
      http.post(
        _uri(ressource),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(content),
      );

  Future<void> reload() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // load verträge, kontakte und news ...
    final response = await http.get(
      _uri('verträge'),
      headers: {
        HttpHeaders.authorizationHeader: _token,
        'client-version': packageInfo.version,
      },
    );
    if (response.statusCode == 426) {
      throw ('Bitte aktuallisieren Sie die App auf die neueste Version.');
    }
    if (response.statusCode != 200) {
      throw ('Failed to get vertraege trouver : ${response.body}');
    }
    vertraege = (jsonDecode(response.body) as List)
        .map((e) => Vertrag.fromJson(e))
        .toList();
  }

  Future<void> sendMeldung(Vorgang meldung) async {
    final response = await postRessource('vorgänge', meldung.toJson());
    if (response.statusCode != 200) {
      throw ('Meldung senden fehlgeschlagen.');
    }
  }

  List<Vertrag> vertraege = <Vertrag>[];

  Future<http.Response> getRessource(String endpoint) => http.get(
        _uri(endpoint),
        headers: {HttpHeaders.authorizationHeader: _token},
      );

  Future<http.Response> postRessource(String endpoint, Object content) =>
      http.post(
        _uri(endpoint),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: _token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(content),
      );

  Future<http.Response> deleteRessource(String endpoint) => http.delete(
        _uri(endpoint),
        headers: {HttpHeaders.authorizationHeader: _token},
      );

  Future<http.Response> putRessource(String endpoint, Object content) =>
      http.put(
        _uri(endpoint),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: _token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(content),
      );
}

/*import 'dart:convert';
import 'dart:io';

import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class PortalService {
  PortalService(this._token);

  final String _token;

  static const bool isProd = bool.fromEnvironment("dart.vm.product");

  // 🔧 Utilise localhost au lieu de 10.0.2.2 pour le mode desktop
  static Uri _uri(String resource) =>
      Uri.http("localhost:8080", 'api/v1/$resource');

  static Future<http.Response> publicPost(String ressource, Object content) =>
      http.post(
        _uri(ressource),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(content),
      );

  Future<void> reload() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // load verträge, kontakte und news ...
    final response = await http.get(
      _uri('verträge'),
      headers: {
        HttpHeaders.authorizationHeader: _token,
        'client-version': packageInfo.version,
      },
    );
    if (response.statusCode == 426) {
      throw ('Bitte aktuallisieren Sie die App auf die neueste Version.');
    }
    if (response.statusCode != 200) {
      throw ('Failed to get vertraege: ${response.body}');
    }
    vertraege = (jsonDecode(response.body) as List)
        .map((e) => Vertrag.fromJson(e))
        .toList();
  }

  Future<void> sendMeldung(Vorgang meldung) async {
    final response = await postRessource('vorgänge', meldung.toJson());
    if (response.statusCode != 200) {
      throw ('Meldung senden fehlgeschlagen.');
    }
  }

  List<Vertrag> vertraege = <Vertrag>[];

  Future<http.Response> getRessource(String endpoint) => http.get(
        _uri(endpoint),
        headers: {HttpHeaders.authorizationHeader: _token},
      );

  Future<http.Response> postRessource(String endpoint, Object content) =>
      http.post(
        _uri(endpoint),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: _token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(content),
      );

  Future<http.Response> deleteRessource(String endpoint) => http.delete(
        _uri(endpoint),
        headers: {HttpHeaders.authorizationHeader: _token},
      );

  Future<http.Response> putRessource(String endpoint, Object content) =>
      http.put(
        _uri(endpoint),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: _token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(content),
      );
}*/
