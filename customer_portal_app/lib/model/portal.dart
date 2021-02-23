// global datainterface for the app?

// login state
// refresh
// get verträge
// melden
// get contacts

import 'dart:convert';
import 'dart:io';

import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Portal {
  static Future<Portal> restore() async {
    final portal = Portal();

    await portal._readToken();

    if (portal._token == null || portal._token.isEmpty) {
      return portal;
    }

    await portal.reload();
    portal.loggedIn = true;

    return portal;
  }

  static const String _tokenKey = 'token';
  final _storage = FlutterSecureStorage();
  String _token;

  Uri _uri(String resource) => Uri.http("10.0.2.2:8080", 'api/v1/' + resource);

  Future<void> login(String user, String password, String gruppe) async {
    loggedIn = false;
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
    await _storage.write(key: _tokenKey, value: _token);
    loggedIn = true;
  }

  Future<void> _readToken() async {
    _token = await _storage.read(key: _tokenKey);
  }

  Future<void> reload() async {
    if (_token.isEmpty) {
      throw ("no access token available");
    }
    // load verträge, kontakte und news ...
    final response = await http.get(
      _uri('vertraege'),
      headers: {HttpHeaders.authorizationHeader: _token},
    );
    if (response.statusCode != 200) {
      throw ('Failed to get vertraege: ' + response.body);
    }
    // TODO parse and store verträge
  }

  bool loggedIn = false;

  List<Vertrag> get vertraege => <Vertrag>[
        Vertrag(
          id: '<uuid-1>',
          sparte: 'KfZ-Versicherung',
          gesellschaft: 'AXA',
          vertragsnummer: '40333844647',
          ablauf: DateTime(2021, 11, 3),
          status: VertragStatus.aktiv,
          beitrag: '750,00 €',
          risiko: 'N HK 334',
          aufnahmeKategorien: <VertragAufnahmeKategorie>[
            VertragAufnahmeKategorie(
              id: 'ausweisVorderseite',
              label: 'Ausweis\u{00AD}vorderseite',
            ),
            VertragAufnahmeKategorie(
              id: 'ausweisRückseite',
              label: 'Ausweis\u{00AD}rückseite',
            ),
            VertragAufnahmeKategorie(
              id: 'führerscheinVorderseite',
              label: 'Führerschein\u{00AD}vorderseite',
            ),
            VertragAufnahmeKategorie(
              id: 'führerscheinrückseite',
              label: 'Führerschein\u{00AD}rückseite',
            ),
            VertragAufnahmeKategorie(
              id: 'grüne karte',
              label: 'Grüne Karte',
            ),
            VertragAufnahmeKategorie(
              id: 'gegnerischesKennzeichen',
              label: 'Gegnerisches Kennzeichen',
            ),
            VertragAufnahmeKategorie(
              id: 'unfall',
              label: 'Unfall\u{00AD}aufnahme',
              max: 3,
            ),
          ],
        ),
        Vertrag(
          id: '<uuid-2>',
          sparte: 'KfZ-Versicherung',
          gesellschaft: 'AXA',
          vertragsnummer: '40333846284',
          ablauf: DateTime(2021, 11, 3),
          status: VertragStatus.aktiv,
          beitrag: '750,00 €',
          risiko: 'N HK 333',
          aufnahmeKategorien: <VertragAufnahmeKategorie>[
            VertragAufnahmeKategorie(
              id: 'ausweisVorderseite',
              label: 'Ausweis\u{00AD}vorderseite',
            ),
            VertragAufnahmeKategorie(
              id: 'ausweisRückseite',
              label: 'Ausweis\u{00AD}rückseite',
            ),
            VertragAufnahmeKategorie(
              id: 'führerscheinVorderseite',
              label: 'Führerschein\u{00AD}vorderseite',
            ),
            VertragAufnahmeKategorie(
              id: 'führerscheinrückseite',
              label: 'Führerschein\u{00AD}rückseite',
            ),
            VertragAufnahmeKategorie(
              id: 'grüneKarte',
              label: 'Grüne Karte',
            ),
            VertragAufnahmeKategorie(
              id: 'gegnerischesKennzeichen',
              label: 'Gegnerisches Kennzeichen',
            ),
            VertragAufnahmeKategorie(
              id: 'unfall',
              label: 'Unfall\u{00AD}aufnahme',
              max: 3,
            ),
          ],
        ),
      ];
}
