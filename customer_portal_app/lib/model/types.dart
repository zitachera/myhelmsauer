import 'package:dataclass/dataclass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:time_machine/time_machine.dart';

@dataClass
class Vertrag {
  final int id;
  final String name;
  final String versicherer;
  final LocalDate beginn;
  final String description;

  Vertrag(
      {this.id, this.name, this.versicherer, this.beginn, this.description});
}

@dataClass
class Vorfall {
  final int id;
  final String titel;
  final int vertragsID;
  final LocalDateTime zeitpunkt;
  final String description;
  final String ort;
  final Position gps;
  final List<String> detailAufnahmen;
  final List<String> gesamtAufnahmen;
  final List<String> fahrzeugscheinAufnahmen;
  final BearbeitungsStatus status;

  Vorfall({
    this.id,
    this.titel,
    this.vertragsID,
    this.zeitpunkt,
    this.description,
    this.ort,
    this.gps,
    this.detailAufnahmen = const <String>[],
    this.gesamtAufnahmen = const <String>[],
    this.fahrzeugscheinAufnahmen = const <String>[],
    this.status,
  });
}

enum BearbeitungsStatus {
  unvollstaendig,
  wirdGesendet,
  inBearbeitung,
  abgeschlossen,
}
