import 'package:customer_portal_app/components/bearbeitungsstatus.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/pages/vertrag.dart';
import 'package:customer_portal_app/pages/vorfall.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Vorfall> vorfaelle = <Vorfall>[
    Vorfall(
      id: Uuid().v1(),
      vertragsID: '<uuid-1>',
      zeitpunkt: LocalDateTime(2020, 01, 20, 9, 50, 10),
      ort: "Coronastr 3",
      description:
          "Sökldfj skfj piosjwf iojs siojsfe sepj säpioj äpsoei sfjuio fsen ueo sehf oisefn.",
      titel: "Fall X",
      status: BearbeitungsStatus.wirdGesendet,
    ),
    Vorfall(
      id: Uuid().v1(),
      vertragsID: '<uuid-2>',
      zeitpunkt: LocalDateTime(2020, 01, 28, 17, 15, 10),
      ort: "Coronastr 3",
      titel: "Fall Y",
      status: BearbeitungsStatus.inBearbeitung,
    ),
    Vorfall(
      id: Uuid().v1(),
      vertragsID: '<uuid-1>',
      zeitpunkt: LocalDateTime(2019, 01, 20, 9, 50, 10),
      ort: "Coronastr 3",
      description:
          "Sökldfj skfj piosjwf iojs siojsfe sepj säpioj äpsoei sfjuio fsen ueo sehf oisefn.",
      titel: "Fall Z",
      status: BearbeitungsStatus.abgeschlossen,
    ),
    Vorfall(
      id: Uuid().v1(),
      vertragsID: '<uuid-2>',
      zeitpunkt: LocalDateTime(2018, 01, 28, 17, 15, 10),
      ort: "Coronastr 3",
      description:
          "Sökldfj skfj piosjwf iojs siojsfe sepj säpioj äpsoei sfjuio fsen ueo sehf oisefn.",
      titel: "Fall W",
      status: BearbeitungsStatus.abgeschlossen,
    ),
  ];
  List<Vertrag> vertraege = <Vertrag>[
    Vertrag(
      id: '<uuid-1>',
      name: "Vertrag A",
      beginn: LocalDate(2009, 11, 3),
      versicherer: "AXA",
      description:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
    ),
    Vertrag(
      id: '<uuid-2>',
      name: "Vertrag B",
      beginn: LocalDate(2011, 09, 7),
      versicherer: "HDI",
      description:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
    ),
  ];

  Vertrag vertragZuVorfall(Vorfall vorfall) => vertraege.firstWhere(
        (v) => v.id == vorfall.vertragsID,
      );

  bool isHidden(Vorfall v) =>
      hideAbgeschlossen && v.status == BearbeitungsStatus.abgeschlossen;

  bool hideAbgeschlossen = true;

  Iterable<Vorfall> get visibleVorfaelle =>
      vorfaelle.where((v) => !isHidden(v));
  Iterable<Vorfall> get hiddenVorfaelle => vorfaelle.where(isHidden);

  @override
  Widget build(BuildContext context) {
    return HsNestedScrollScaffold(
      title: 'Hemlsauer',
      body: Column(
        children: <Widget>[
          if (visibleVorfaelle.isNotEmpty)
            Text(
              "Meine Vorfälle",
              textScaleFactor: 2,
            ),
          ...visibleVorfaelle.map(
            (vorfall) => _buildVorfall(
              context,
              vorfall,
            ),
          ),
          if (hiddenVorfaelle.isNotEmpty)
            FlatButton(
              onPressed: () {
                setState(() => hideAbgeschlossen = false);
              },
              child: Text("${hiddenVorfaelle.length} Abgeschlossene Vorfälle"),
            ),
          if (!hideAbgeschlossen)
            FlatButton(
              onPressed: () {
                setState(() => hideAbgeschlossen = true);
              },
              child: Text("Abgeschlossene Vorfälle ausblenden"),
            ),
          Text(
            "Meine Verträge",
            textScaleFactor: 2,
          ),
          ...vertraege.map(
            (vertrag) => _buildVertrag(
              context,
              vertrag,
            ),
          ),
        ],
      ),
    );
  }

  FlatButton _buildVertrag(BuildContext context, Vertrag vertrag) {
    return FlatButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VertragPage(vertrag: vertrag)),
        ),
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              vertrag.name,
              textScaleFactor: 1.3,
            ),
          ),
          Expanded(
            child: Text(
              vertrag.versicherer,
              textScaleFactor: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  FlatButton _buildVorfall(BuildContext context, Vorfall vorfall) {
    return FlatButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VorfallPage(
                    vorfall: vorfall,
                    vertrag: vertragZuVorfall(vorfall),
                  )),
        ),
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              vorfall.zeitpunkt.toString('dd.MM.yyyy HH:mm'),
              textScaleFactor: 1.3,
            ),
          ),
          Expanded(
            child: Text(
              vorfall.titel,
              textScaleFactor: 1.3,
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: BearbeitungsStatusBadge(vorfall.status)),
          ),
        ],
      ),
    );
  }
}
