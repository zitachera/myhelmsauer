import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
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
}

@dataClass
class Vorfall {
  final String id;
  final String titel;
  final String vertragsID;
  final LocalDateTime zeitpunkt;
  final String description;
  final String ort;
  final Position gps;
  final List<String> detailAufnahmen;
  final List<String> gesamtAufnahmen;
  final List<String> fahrzeugscheinAufnahmen;
  final BearbeitungsStatus status;

  Vorfall({
    @required this.id,
    this.titel,
    @required this.vertragsID,
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
