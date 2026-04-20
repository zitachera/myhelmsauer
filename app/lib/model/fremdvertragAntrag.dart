/*import 'dart:convert';
import 'dart:typed_data';

class FremdvertragAntrag {
  final List<Uint8List> aufnahmen;
  final Map<String, Uint8List> files;

  final bool integrieren;
  final bool vergleichsangebotErstellen;

  FremdvertragAntrag({
    required this.aufnahmen,
    required this.files,
    required this.integrieren,
    required this.vergleichsangebotErstellen,
  });

  FremdvertragAntrag.fromJson(Map<String, dynamic> json)
      : aufnahmen =
            (json['aufnahmen'] as List<String>).map(base64Decode).toList(),
        files = (json['files'] as Map<String, String>)
            .map((key, value) => MapEntry(key, base64Decode(value))),
        integrieren = json['integrieren'],
        vergleichsangebotErstellen = json['vergleichsangebotErstellen'];

  Map<String, dynamic> toJson() => {
        'aufnahmen': aufnahmen.map(base64Encode).toList(),
        'files': files.map((key, value) => MapEntry(key, base64Encode(value))),
        'integrieren': integrieren,
        'vergleichsangebotErstellen': vergleichsangebotErstellen,
      };
}*/

import 'dart:convert';
import 'dart:typed_data';

class FremdvertragAntrag {
  /// Photos prises dans l'application
  final List<Uint8List> aufnahmen;

  /// Fichiers joints (nom + contenu binaire)
  final Map<String, Uint8List> files;

  /// Contrat doit être intégré dans le portefeuille ?
  final bool integrieren;

  /// Offre comparative demandée ?
  final bool vergleichsangebotErstellen;

  FremdvertragAntrag({
    required this.aufnahmen,
    required this.files,
    required this.integrieren,
    required this.vergleichsangebotErstellen,
  });

  ///  FACTORY FROM JSON (plus safe)
  factory FremdvertragAntrag.fromJson(Map<String, dynamic> json) {
    return FremdvertragAntrag(
      aufnahmen: (json['aufnahmen'] as List<dynamic>? ?? [])
          .map((e) => base64Decode(e as String))
          .toList(),
      files: (json['files'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, base64Decode(value as String))),
      integrieren: json['integrieren'] ?? false,
      vergleichsangebotErstellen: json['vergleichsangebotErstellen'] ?? false,
    );
  }

  ///  TO JSON (Backend ready)
  Map<String, dynamic> toJson() => {
        'aufnahmen': aufnahmen.map(base64Encode).toList(),
        'files': files.map(
          (key, value) => MapEntry(key, base64Encode(value)),
        ),
        'integrieren': integrieren,
        'vergleichsangebotErstellen': vergleichsangebotErstellen,
      };

  ///  COPY WITH (très utile pour UI state management)
  FremdvertragAntrag copyWith({
    List<Uint8List>? aufnahmen,
    Map<String, Uint8List>? files,
    bool? integrieren,
    bool? vergleichsangebotErstellen,
  }) {
    return FremdvertragAntrag(
      aufnahmen: aufnahmen ?? this.aufnahmen,
      files: files ?? this.files,
      integrieren: integrieren ?? this.integrieren,
      vergleichsangebotErstellen:
          vergleichsangebotErstellen ?? this.vergleichsangebotErstellen,
    );
  }

  ///  Debug plus propre
  @override
  String toString() {
    return 'FremdvertragAntrag('
        'aufnahmen: ${aufnahmen.length}, '
        'files: ${files.length}, '
        'integrieren: $integrieren, '
        'vergleichsangebotErstellen: $vergleichsangebotErstellen'
        ')';
  }
}
