import 'dart:convert';
import 'dart:typed_data';

import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
@dataClass
class Vorgang {
  final String id;
  final String vertragsID;
  final DateTime zeitpunkt;
  final String schadenhergang;
  final String ort;
  final Position gps;
  final Map<String, List<Uint8List>> aufnahmen;

  Vorgang({
    @required this.id,
    @required this.vertragsID,
    this.zeitpunkt,
    this.schadenhergang,
    this.ort,
    this.gps,
    this.aufnahmen,
  });

  Vorgang.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        vertragsID = json['vertragsID'],
        zeitpunkt = DateTime.parse(json['zeitpunkt']),
        schadenhergang = json['schadenhergang'],
        ort = json['ort'],
        gps = Position(
          latitude: json['latitude'],
          longitude: json['longitude'],
        ),
        aufnahmen = (json['aufnahmen'] as Map<String, List<String>>)
            .map((key, value) => MapEntry(key, _dataFromBase64Strings(value)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'vertragsID': vertragsID,
        'zeitpunkt': zeitpunkt.toIso8601String(),
        'schadenhergang': schadenhergang,
        'ort': ort,
        'latitude': gps?.latitude,
        'longitude': gps?.longitude,
        'aufnahmen':
            aufnahmen.map((key, value) => MapEntry(key, _base64Strings(value))),
      };
}

List<Uint8List> _dataFromBase64Strings(List<String> base64String) =>
    base64String.map(base64Decode).toList();

List<String> _base64Strings(List<Uint8List> data) =>
    data.map(base64Encode).toList();
