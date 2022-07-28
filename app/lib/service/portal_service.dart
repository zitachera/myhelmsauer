import 'dart:convert';
import 'dart:io';

import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class PortalService {
  PortalService(this._token);

  String _token;

  // Uri _uri(String resource) => Uri.http("10.0.2.2:8080", 'api/v1/' + resource); // debug pc

  static const bool isProd = const bool.fromEnvironment("dart.vm.product");
  static Uri _uri(String resource) => Uri.https(
      isProd ? "schadenmeldung.helmsauer-gruppe.de" : "testschadenmeldung.helmsauer-gruppe.de",
      'api/v1/' + resource);

  static Future<http.Response> publicPost(String ressource, Object content) => http.post(
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
      throw ('Failed to get vertraege: ' + response.body);
    }
    vertraege = (jsonDecode(response.body) as List).map((e) => Vertrag.fromJson(e)).toList();
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

  Future<http.Response> postRessource(String endpoint, Object content) => http.post(
        _uri(endpoint),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: _token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(content),
      );
}
