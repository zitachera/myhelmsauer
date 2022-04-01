class Vertrag {
  final String id;

  final String sparte;
  final String spartenID;
  final String gesellschaft;
  final String vertragsnummer;
  final DateTime ablauf;
  final VertragStatus status;
  final String beitrag;
  final String risiko;
  final List<MeldeTemplate> meldeTemplates;
  final List<VertragDokument> dokumente;

  Vertrag({
    required this.id,
    required this.sparte,
    required this.spartenID,
    required this.gesellschaft,
    required this.vertragsnummer,
    required this.ablauf,
    required this.status,
    required this.beitrag,
    required this.risiko,
    required this.meldeTemplates,
    required this.dokumente,
  });

  Vertrag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sparte = json['sparte'],
        spartenID = json['spartenID'],
        gesellschaft = json['gesellschaft'],
        vertragsnummer = json['vertragsnummer'],
        ablauf = DateTime.parse(json['ablauf']),
        status = _jsonToVertragStatus(json['status']),
        beitrag = json['beitrag'],
        risiko = json['risiko'],
        meldeTemplates =
            (json['meldeTemplates'] as List).map((e) => MeldeTemplate.fromJson(e)).toList(),
        dokumente = (json['dokumente'] as List).map((e) => VertragDokument.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'sparte': sparte,
        'spartenID': spartenID,
        'gesellschaft': gesellschaft,
        'vertragsnummer': vertragsnummer,
        'ablauf': ablauf.toIso8601String(),
        'status': _vertragStatusToJson(status),
        'beitrag': beitrag,
        'risiko': risiko,
        'meldeTemplates': meldeTemplates.map((e) => e.toJson()).toList(),
        'dokumente': dokumente.map((e) => e.toJson()).toList(),
      };

  bool get hasSchadenTemplate {
    return meldeTemplates.where((t) => t.id == MeldeTemplate.schadenId).isNotEmpty;
  }

  MeldeTemplate get schadenTemplate {
    return meldeTemplates.firstWhere(
      (t) => t.id == MeldeTemplate.schadenId,
    );
  }
}

enum VertragStatus {
  aktiv,
  antrag,
  storno,
  other,
}

class VertragDokument {
  final String endpoint;

  final String titel;

  VertragDokument({
    required this.endpoint,
    required this.titel,
  });

  VertragDokument.fromJson(Map<String, dynamic> json)
      : endpoint = json['endpoint'],
        titel = json['titel'];

  Map<String, dynamic> toJson() => {
        'endpoint': endpoint,
        'titel': titel,
      };
}

class MeldeTemplate {
  final String id;
  final String name;
  final List<MeldeFeld> felder;

  MeldeTemplate({
    required this.id,
    required this.name,
    required this.felder,
  });

  MeldeTemplate.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        felder = (json['felder'] as List).map((e) => MeldeFeld.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'felder': felder.map((e) => e.toJson()).toList(),
      };

  static const String schadenId = "schaden";
}

class MeldeFeld {
  final String id;
  final String label;
  final MeldeFeldKind kind;
  final String beschreibung;
  final int max;
  final int min;

  MeldeFeld({
    required this.id,
    required this.label,
    required this.kind,
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

String _vertragStatusToJson(VertragStatus status) => status.toString().split('.')[1];

VertragStatus _jsonToVertragStatus(String status) => VertragStatus.values
    .firstWhere((v) => _vertragStatusToJson(v) == status, orElse: () => VertragStatus.other);

enum MeldeFeldKind {
  images,
  textfield,
  multiline,
  section,
  choice,
  time,
  date,
  location,
}

String _meldeFeldKindToJson(MeldeFeldKind status) => status.toString().split('.')[1];

MeldeFeldKind _jsonToMeldeFeldKind(String status) =>
    MeldeFeldKind.values.firstWhere((v) => _meldeFeldKindToJson(v) == status);
