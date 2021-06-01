import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@dataClass
class Vertrag {
  final String id;

  final String sparte;
  final String gesellschaft;
  final String vertragsnummer;
  final DateTime ablauf;
  final VertragStatus status;
  final String beitrag;
  final String risiko;
  final List<MeldeFeld> meldeFelder;
  final List<VertragDokument> dokumente;

  Vertrag({
    @required this.id,
    this.sparte,
    this.gesellschaft,
    this.vertragsnummer,
    this.ablauf,
    this.status,
    this.beitrag,
    this.risiko,
    this.meldeFelder,
    this.dokumente,
  });

  Vertrag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sparte = json['sparte'],
        gesellschaft = json['gesellschaft'],
        vertragsnummer = json['vertragsnummer'],
        ablauf = DateTime.parse(json['ablauf']),
        status = _jsonToVertragStatus(json['status']),
        beitrag = json['beitrag'],
        risiko = json['risiko'],
        meldeFelder =
            ((json['aufnahmeKategorien'] ?? json['aufnahmeKategorien']) as List)
                .map((e) => MeldeFeld.fromJson(e))
                .toList(),
        dokumente = (json['dokumente'] as List)
            .map((e) => VertragDokument.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'sparte': sparte,
        'gesellschaft': gesellschaft,
        'vertragsnummer': vertragsnummer,
        'ablauf': ablauf.toIso8601String(),
        'status': _vertragStatusToJson(status),
        'beitrag': beitrag,
        'risiko': risiko,
        'meldeFelder': meldeFelder.map((e) => e.toJson()).toList(),
        'dokumente': dokumente.map((e) => e.toJson()).toList(),
      };
}

enum VertragStatus {
  aktiv,
  antrag,
  storno,
}

@dataClass
class VertragDokument {
  final String endpoint;

  final String titel;

  VertragDokument({
    @required this.endpoint,
    this.titel,
  });

  VertragDokument.fromJson(Map<String, dynamic> json)
      : endpoint = json['endpoint'],
        titel = json['titel'];

  Map<String, dynamic> toJson() => {
        'endpoint': endpoint,
        'titel': titel,
      };
}

class MeldeFeld {
  final String id;
  final String label;
  final MeldeFeldKind kind;
  final String beschreibung;
  final int max;
  final int min;

  MeldeFeld({
    @required this.id,
    @required this.label,
    @required this.kind,
    this.beschreibung = "",
    this.max = 1,
    this.min = 0,
  });

  MeldeFeld.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        label = json['label'],
        kind = _jsonToMeldeFeldKind(json['kind']),
        beschreibung = json['beschreibung'] ?? "",
        max = json['max'],
        min = json['min'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'kind': kind.toString(),
        'beschreibung': beschreibung,
        'max': max,
        'min': min,
      };
}

String _vertragStatusToJson(VertragStatus status) =>
    status.toString().split('.')[1];

VertragStatus _jsonToVertragStatus(String status) =>
    VertragStatus.values.firstWhere((v) => _vertragStatusToJson(v) == status);

enum MeldeFeldKind { images, textfield, section }

String _meldeFeldKindToJson(MeldeFeldKind status) =>
    status.toString().split('.')[1];

MeldeFeldKind _jsonToMeldeFeldKind(String status) =>
    MeldeFeldKind.values.firstWhere((v) => _meldeFeldKindToJson(v) == status);
