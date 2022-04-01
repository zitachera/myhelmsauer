import 'dart:convert';
import 'dart:typed_data';

class Vorgang {
  final String id;
  final String vertragsID;
  final String templateID;
  final DateTime zeitpunkt;
  final String ort;
  final double? latitude;
  final double? longitude;
  final Map<String, List<Uint8List>> aufnahmen;
  final Map<String, String> felder;

  Vorgang({
    required this.id,
    required this.vertragsID,
    required this.templateID,
    required this.zeitpunkt,
    required this.ort,
    this.latitude,
    this.longitude,
    required this.aufnahmen,
    required this.felder,
  });

  Vorgang.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        vertragsID = json['vertragsID'],
        templateID = json['templateID'],
        zeitpunkt = DateTime.parse(json['zeitpunkt']),
        ort = json['ort'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        aufnahmen = (json['aufnahmen'] as Map<String, List<String>>)
            .map((key, value) => MapEntry(key, _dataFromBase64Strings(value))),
        felder = (json['felder'] as Map<String, String>);

  Map<String, dynamic> toJson() => {
        'id': id,
        'vertragsID': vertragsID,
        'templateID': templateID,
        'zeitpunkt': zeitpunkt.toIso8601String(),
        'ort': ort,
        'latitude': latitude,
        'longitude': longitude,
        'aufnahmen': aufnahmen.map((key, value) => MapEntry(key, _base64Strings(value))),
        'felder': felder,
      };
}

List<Uint8List> _dataFromBase64Strings(List<String> base64String) =>
    base64String.map(base64Decode).toList();

List<String> _base64Strings(List<Uint8List> data) => data.map(base64Encode).toList();
