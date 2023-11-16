import 'dart:typed_data';
import 'dart:convert';

class Wertgegenstand {
  final int id;
  final DateTime creationDate;
  final DateTime updateDate;
  final String name;
  final String beschreibung;

  final double wert;
  final Uint8List image;

  Wertgegenstand({
    required this.id,
    required this.creationDate,
    required this.updateDate,
    required this.name,
    required this.beschreibung,
    required this.wert,
    required this.image,
  });

  Wertgegenstand.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        creationDate = DateTime.parse(json['creationDate']),
        updateDate = DateTime.parse(json['updateDate']),
        name = json['name'],
        beschreibung = json['beschreibung'],
        wert = json['wert'].toDouble(),
        image = base64Decode(json['image']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'creationDate': creationDate.toIso8601String(),
        'updateDate': updateDate.toIso8601String(),
        'name': name,
        'beschreibung': beschreibung,
        'wert': wert,
        'image': base64Encode(image),
      };

  Wertgegenstand.empty()
      : id = 0,
        creationDate = DateTime.now(),
        updateDate = DateTime.now(),
        name = '',
        beschreibung = '',
        wert = 0,
        image = Uint8List(0);

  Wertgegenstand copyWith({
    int? id,
    DateTime? creationDate,
    DateTime? updateDate,
    String? name,
    String? beschreibung,
    double? wert,
    Uint8List? image,
  }) {
    return Wertgegenstand(
      id: id ?? this.id,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      name: name ?? this.name,
      beschreibung: beschreibung ?? this.beschreibung,
      wert: wert ?? this.wert,
      image: image ?? this.image,
    );
  }
}
