import 'dart:convert';
import 'dart:io';

import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';

class Portal {
  static Future<Portal> restore() async {
    final portal = Portal();

    await portal._readToken();

    if (portal._token == null || portal._token!.isEmpty) {
      return portal;
    }

    await portal.reload();
    portal.loggedIn = true;

    return portal;
  }

  static Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  static const String _tokenKey = 'token';
  static final _storage = FlutterSecureStorage();
  String? _token;

  // Uri _uri(String resource) => Uri.http("10.0.2.2:8080", 'api/v1/' + resource); // debug pc

  static const bool isProd = const bool.fromEnvironment("dart.vm.product");
  static Uri _uri(String resource) => Uri.https(
      isProd
          ? "schadenmeldung.helmsauer-gruppe.de"
          : "testschadenmeldung.helmsauer-gruppe.de",
      'api/v1/' + resource);

  Future<void> login(String user, String password, String gruppe) async {
    loggedIn = false;

    final response = await publicPost(
      'login',
      <String, String>{
        'user': user,
        'password': password,
        'gruppe': gruppe,
      },
    );
    if (response.statusCode != 200) {
      throw ('Login fehlgeschlagen.');
    }
    _token = jsonDecode(response.body)["token"];
    await _writeToken();
    await reload();
    loggedIn = true;
  }

  static Future<http.Response> publicPost(
      String ressource, Object content) async {
    return await http.post(
      _uri(ressource),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(content),
    );
  }

  Future<void> _readToken() async {
    _token = await (_storage.read(key: _tokenKey));
  }

  Future<void> _writeToken() async {
    var token = _token!;
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> reload() async {
    if (_token!.isEmpty) {
      throw ("no access token available");
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // load verträge, kontakte und news ...
    final response = await http.get(
      _uri('verträge'),
      headers: {
        HttpHeaders.authorizationHeader: _token!,
        'client-version': packageInfo.version,
      },
    );
    if (response.statusCode == 426) {
      throw ('Bitte aktuallisieren Sie die App auf die neueste Version.');
    }
    if (response.statusCode != 200) {
      throw ('Failed to get vertraege: ' + response.body);
    }
    vertraege = (jsonDecode(response.body) as List)
        .map((e) => Vertrag.fromJson(e))
        .toList();
  }

  Future<void> sendMeldung(Vorgang meldung) async {
    final response = await http.post(
      _uri('vorgänge'),
      headers: {HttpHeaders.authorizationHeader: _token!},
      body: jsonEncode(meldung.toJson()),
    );
    if (response.statusCode != 200) {
      throw ('Meldung senden fehlgeschlagen.');
    }
  }

  bool loggedIn = false;

  List<Vertrag> vertraege = <Vertrag>[];

  Future<http.Response> getRessource(String endpoint) => http.get(
        _uri(endpoint),
        headers: {HttpHeaders.authorizationHeader: _token!},
      );
}
