import 'dart:convert';
import 'dart:typed_data';

import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:time_machine/time_machine.dart';

@JsonSerializable()
@dataClass
class Vorgang {
  final String id;
  final String titel;
  final String vertragsID;
  final LocalDateTime zeitpunkt;
  final String schadenhergang;
  final String ort;
  final Position gps;
  final List<Uint8List> detailAufnahmen;
  final List<Uint8List> gesamtAufnahmen;
  final List<Uint8List> fahrzeugscheinAufnahmen;

  Vorgang({
    @required this.id,
    this.titel,
    @required this.vertragsID,
    this.zeitpunkt,
    this.schadenhergang,
    this.ort,
    this.gps,
    this.detailAufnahmen = const <Uint8List>[],
    this.gesamtAufnahmen = const <Uint8List>[],
    this.fahrzeugscheinAufnahmen = const <Uint8List>[],
  });

  Vorgang.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        titel = json['titel'],
        vertragsID = json['vertragsID'],
        zeitpunkt = LocalDateTime.dateTime(DateTime.parse(json['zeitpunkt'])),
        schadenhergang = json['schadenhergang'],
        ort = json['ort'],
        gps = Position(
          latitude: json['latitude'],
          longitude: json['longitude'],
        ),
        detailAufnahmen = _dataFromBase64Strings(json['detailAufnahmen']),
        gesamtAufnahmen = _dataFromBase64Strings(json['gesamtAufnahmen']),
        fahrzeugscheinAufnahmen =
            _dataFromBase64Strings(json['fahrzeugscheinAufnahmen']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'titel': titel,
        'vertragsID': vertragsID,
        'zeitpunkt': zeitpunkt.toDateTimeLocal().toIso8601String(),
        'schadenhergang': schadenhergang,
        'ort': ort,
        'latitude': gps.latitude,
        'longitude': gps.longitude,
        'detailAufnahmen': _base64Strings(detailAufnahmen),
        'gesamtAufnahmen': _base64Strings(gesamtAufnahmen),
        'fahrzeugscheinAufnahmen': _base64Strings(fahrzeugscheinAufnahmen),
      };
}

List<Uint8List> _dataFromBase64Strings(List<String> base64String) =>
    base64String.map(base64Decode).toList();

List<String> _base64Strings(List<Uint8List> data) =>
    data.map(base64Encode).toList();
