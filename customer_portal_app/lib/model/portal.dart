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
  static const String _tokenKey = 'token';
  final _storage = FlutterSecureStorage();

  Uri _uri(String resource) => Uri.http("HK0270:9999", 'api/v1/' + resource);

  Future<void> login(String user, String password, String gruppe) async {
    loegedIn = false;
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
      throw ('Failed to log in: ' + response.body);
    }
    await _storage.write(
        key: _tokenKey, value: jsonDecode(response.body)["token"]);
  }

  Future<void> reload() async {
    var token = await _storage.read(key: _tokenKey);
    if (token.isEmpty) {
      throw ("no access token available");
    }
    // load verträge, kontakte und news ...
    final response = await http.get(
      _uri('vertraege'),
      headers: {HttpHeaders.authorizationHeader: token},
    );
    if (response.statusCode != 200) {
      throw ('Failed to get vertraege: ' + response.body);
    }
    // TODO parse and store verträge
  }

  bool loegedIn;

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
