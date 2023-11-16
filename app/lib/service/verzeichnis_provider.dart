import 'dart:convert';
import 'dart:developer';

import 'package:customer_portal_app/model/wertgegenstand.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter/material.dart';

class VerzeichnisProvider extends ChangeNotifier {
  VerzeichnisProvider(this._portal);

  PortalService _portal;

  List<Wertgegenstand>? _verzeichnis;

  List<Wertgegenstand>? get verzeichnis => _verzeichnis;

  String? _fehler;

  String? get fehler => _fehler;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _updated = false;

  bool get updated => _updated;

  set fehler(String? value) {
    _fehler = value;
    notifyListeners();
  }

  set verzeichnis(List<Wertgegenstand>? value) {
    _verzeichnis = value;
    _fehler = null;
    notifyListeners();
  }

  Future<void> reload() async {
    try {
      loading = true;
      final response = await _portal.getRessource('verzeichnis');
      if (response.statusCode != 200) {
        log('Failed to get verzeichnis: ' + response.body);
        fehler = 'Verzeichnis laden fehlgeschlagen.';
      }
      loadJSON(response.body);
    } catch (e) {
      log('Failed to load verzeichnis: ' + e.toString());
      fehler = 'Verzeichnis laden fehlgeschlagen.';
    }
  }

  Future<void> delete(Wertgegenstand wertgegenstand) async {
    loading = true;
    final response = await _portal.deleteRessource('verzeichnis/${wertgegenstand.id}');
    if (response.statusCode != 200) {
      log('Failed to delete wertgegenstand: ' + response.body);
      fehler = 'Wertgegenstand löschen fehlgeschlagen.';
    }
    _updated = true;
    loadJSON(response.body);
  }

  Future<void> update(Wertgegenstand wertgegenstand) async {
    loading = true;
    final response = await _portal.putRessource('verzeichnis', wertgegenstand.toJson());
    if (response.statusCode != 200) {
      throw ('Failed to update wertgegenstand: ' + response.body);
    }
    _updated = true;
    loadJSON(response.body);
  }

  void loadJSON(String json) {
    _loading = false;
    verzeichnis = (jsonDecode(json) as List).map((e) => Wertgegenstand.fromJson(e)).toList();
  }
}
