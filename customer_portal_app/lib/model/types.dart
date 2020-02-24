import 'dart:convert';
import 'dart:typed_data';

import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:time_machine/time_machine.dart';

@dataClass
class Vertrag {
  final String id;
  final String name;
  final String versicherer;
  final LocalDate beginn;
  final String description;

  Vertrag({
    @required this.id,
    this.name,
    this.versicherer,
    this.beginn,
    this.description,
  });

  Vertrag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        versicherer = json['versicherer'],
        beginn = LocalDate.dateTime(DateTime.parse(json['beginn'])),
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'versicherer': versicherer,
        'beginn': beginn.toDateTimeUnspecified().toIso8601String(),
        'description': description,
      };
}

@JsonSerializable()
@dataClass
class Vorgang {
  final String id;
  final String titel;
  final String vertragsID;
  final LocalDateTime zeitpunkt;
  final String description;
  final String ort;
  final Position gps;
  final List<Uint8List> detailAufnahmen;
  final List<Uint8List> gesamtAufnahmen;
  final List<Uint8List> fahrzeugscheinAufnahmen;
  final BearbeitungsStatus status;

  Vorgang({
    @required this.id,
    this.titel,
    @required this.vertragsID,
    this.zeitpunkt,
    this.description,
    this.ort,
    this.gps,
    this.detailAufnahmen = const <Uint8List>[],
    this.gesamtAufnahmen = const <Uint8List>[],
    this.fahrzeugscheinAufnahmen = const <Uint8List>[],
    this.status,
  });

  Vorgang.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        titel = json['titel'],
        vertragsID = json['vertragsID'],
        zeitpunkt = LocalDateTime.dateTime(DateTime.parse(json['zeitpunkt'])),
        description = json['description'],
        ort = json['ort'],
        gps = Position(
          latitude: json['latitude'],
          longitude: json['longitude'],
        ),
        detailAufnahmen = _dataFromBase64Strings(json['detailAufnahmen']),
        gesamtAufnahmen = _dataFromBase64Strings(json['gesamtAufnahmen']),
        fahrzeugscheinAufnahmen =
            _dataFromBase64Strings(json['fahrzeugscheinAufnahmen']),
        status = _jsonToBearbeitungsStatus(json['status']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'titel': titel,
        'vertragsID': vertragsID,
        'zeitpunkt': zeitpunkt.toDateTimeLocal().toIso8601String(),
        'description': description,
        'ort': ort,
        'latitude': gps.latitude,
        'longitude': gps.longitude,
        'detailAufnahmen': _base64Strings(detailAufnahmen),
        'gesamtAufnahmen': _base64Strings(gesamtAufnahmen),
        'fahrzeugscheinAufnahmen': _base64Strings(fahrzeugscheinAufnahmen),
        'status': _bearbeitungsStatusToJson(status),
      };
}

enum BearbeitungsStatus {
  unvollstaendig,
  wirdGesendet,
  inBearbeitung,
  abgeschlossen,
}

String _bearbeitungsStatusToJson(BearbeitungsStatus status) =>
    status.toString().split('.')[1];

BearbeitungsStatus _jsonToBearbeitungsStatus(String status) =>
    BearbeitungsStatus.values
        .firstWhere((v) => _bearbeitungsStatusToJson(v) == status);

List<Uint8List> _dataFromBase64Strings(List<String> base64String) =>
    base64String.map(base64Decode).toList();

List<String> _base64Strings(List<Uint8List> data) =>
    data.map(base64Encode).toList();
