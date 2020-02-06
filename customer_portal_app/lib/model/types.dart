

import 'package:dataclass/dataclass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:time_machine/time_machine.dart';

@dataClass
class Vertrag {
  final String name;
  final String versicherer;
  final LocalDate beginn;
  final String description;

  Vertrag({this.name, this.versicherer, this.beginn, this.description});
}

@dataClass
class Meldung{
  final String titel;
  final LocalDateTime zeitpunkt;
  final String description;
  final String ort;
  final Position gps;
  final List<String> fotos;
  final BearbeitungsStatus status;

  
  Meldung({this.titel, this.zeitpunkt, this.description, this.ort, this.gps, this.fotos, this.status});
}

enum BearbeitungsStatus{
  unvollstaendig,
  wirdGesendet,
  inBearbeitung,
  abgeschlossen,
}