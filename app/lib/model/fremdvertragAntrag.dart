import 'dart:convert';
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
}
