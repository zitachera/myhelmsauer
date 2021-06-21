import 'dart:convert';
import 'dart:io';

import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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
  bool _testServer = false;
  static const String _testPrefix = "-<test>-";

  // Uri _uri(String resource) => Uri.http("10.0.2.2:8080", 'api/v1/' + resource); // debug pc

  Uri _uri(String resource) => Uri.https(
      _testServer
          ? "testschadenmeldung.helmsauer-gruppe.de"
          : "schadenmeldung.helmsauer-gruppe.de",
      'api/v1/' + resource);

  Future<void> login(String user, String password, String gruppe) async {
    loggedIn = false;
    if (user.startsWith(_testPrefix)) {
      _testServer = true;
      user = user.substring(_testPrefix.length);
    }
    final response = await http.post(
      _uri('login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': user,
        'password': password,
        'gruppe': gruppe,
      }),
    );
    if (response.statusCode != 200) {
      throw ('Login fehlgeschlagen.');
    }
    _token = jsonDecode(response.body)["token"];
    await _writeToken();
    await reload();
    loggedIn = true;
  }

  Future<void> _readToken() async {
    _token = await (_storage.read(key: _tokenKey));

    if (_token != null && _token!.startsWith(_testPrefix)) {
      _testServer = true;
      _token = _token!.substring(_testPrefix.length);
    }
  }

  Future<void> _writeToken() async {
    var token = _token!;
    if (_testServer) token = _testPrefix + token;
    await _storage.write(key: _tokenKey, value: _token);
  }

  Future<void> reload() async {
    if (_token!.isEmpty) {
      throw ("no access token available");
    }
    // load verträge, kontakte und news ...
    final response = await http.get(
      _uri('verträge'),
      headers: {HttpHeaders.authorizationHeader: _token!},
    );
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
