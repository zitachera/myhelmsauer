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

  final String sparte;
  final String gesellschaft;
  final String vertragsnummer;
  final LocalDate ablauf;
  final VertragStatus status;
  final String beitrag;
  final String risiko;

  Vertrag({
    @required this.id,
    this.sparte,
    this.gesellschaft,
    this.vertragsnummer,
    this.ablauf,
    this.status,
    this.beitrag,
    this.risiko,
  });

  Vertrag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sparte = json['sparte'],
        gesellschaft = json['gesellschaft'],
        vertragsnummer = json['vertragsnummer'],
        ablauf = LocalDate.dateTime(DateTime.parse(json['ablauf'])),
        status = _jsonToVertragStatus(json['status']),
        beitrag = json['beitrag'],
        risiko = json['risiko'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'sparte': sparte,
        'gesellschaft': gesellschaft,
        'vertragsnummer': vertragsnummer,
        'ablauf': ablauf.toDateTimeUnspecified().toIso8601String(),
        'status': _vertragStatusToJson(status),
        'beitrag': beitrag,
        'risiko': risiko,
      };
}

enum VertragStatus {
  aktiv,
  antrag,
  storno,
}

String _vertragStatusToJson(VertragStatus status) =>
    status.toString().split('.')[1];

VertragStatus _jsonToVertragStatus(String status) =>
    VertragStatus.values.firstWhere((v) => _vertragStatusToJson(v) == status);
