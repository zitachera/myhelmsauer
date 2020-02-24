import 'package:customer_portal_app/components/bearbeitungsstatus.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/pages/vertrag.dart';
import 'package:customer_portal_app/pages/vorgang.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Vorgang> vorgaengen = <Vorgang>[
    Vorgang(
      id: Uuid().v1(),
      vertragsID: '<uuid-1>',
      zeitpunkt: LocalDateTime(2020, 01, 20, 9, 50, 10),
      ort: "Coronastr 3",
      description:
          "Sökldfj skfj piosjwf iojs siojsfe sepj säpioj äpsoei sfjuio fsen ueo sehf oisefn.",
      titel: "Fall X",
      status: BearbeitungsStatus.wirdGesendet,
    ),
    Vorgang(
      id: Uuid().v1(),
      vertragsID: '<uuid-2>',
      zeitpunkt: LocalDateTime(2020, 01, 28, 17, 15, 10),
      ort: "Coronastr 3",
      titel: "Fall Y",
      status: BearbeitungsStatus.inBearbeitung,
    ),
    Vorgang(
      id: Uuid().v1(),
      vertragsID: '<uuid-1>',
      zeitpunkt: LocalDateTime(2019, 01, 20, 9, 50, 10),
      ort: "Coronastr 3",
      description:
          "Sökldfj skfj piosjwf iojs siojsfe sepj säpioj äpsoei sfjuio fsen ueo sehf oisefn.",
      titel: "Fall Z",
      status: BearbeitungsStatus.abgeschlossen,
    ),
    Vorgang(
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
      sparte: 'Kfz-Versicherung',
      gesellschaft: 'AXA',
      vertragsnummer: '123',
      ablauf: LocalDate(2029, 11, 3),
      status: VertragStatus.aktiv,
      beitrag: '20,00 €',
      risiko: '??',
    ),
    Vertrag(
      id: '<uuid-2>',
      sparte: 'Kfz-Versicherung',
      gesellschaft: 'HDI',
      vertragsnummer: '456',
      ablauf: LocalDate(2029, 11, 3),
      status: VertragStatus.aktiv,
      beitrag: '55,00 €',
      risiko: '??',
    ),
  ];

  Vertrag vertragZuVorgang(Vorgang vorgang) => vertraege.firstWhere(
        (v) => v.id == vorgang.vertragsID,
      );

  bool isHidden(Vorgang v) =>
      hideAbgeschlossen && v.status == BearbeitungsStatus.abgeschlossen;

  bool hideAbgeschlossen = true;

  Iterable<Vorgang> get visibleVorgaengen =>
      vorgaengen.where((v) => !isHidden(v));
  Iterable<Vorgang> get hiddenVorgaengen => vorgaengen.where(isHidden);

  @override
  Widget build(BuildContext context) {
    return HsNestedScrollScaffold(
      title: 'Hemlsauer-Gruppe',
      body: Column(
        children: <Widget>[
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
          if (visibleVorgaengen.isNotEmpty)
            Text(
              "Meine Vorgänge",
              textScaleFactor: 2,
            ),
          ...visibleVorgaengen.map(
            (vorgang) => _buildVorgang(
              context,
              vorgang,
            ),
          ),
          if (hiddenVorgaengen.isNotEmpty)
            FlatButton(
              onPressed: () {
                setState(() => hideAbgeschlossen = false);
              },
              child: Text("${hiddenVorgaengen.length} Abgeschlossene Vorgänge"),
            ),
          if (!hideAbgeschlossen)
            FlatButton(
              onPressed: () {
                setState(() => hideAbgeschlossen = true);
              },
              child: Text("Abgeschlossene Vorgänge ausblenden"),
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
              vertrag.sparte,
              textScaleFactor: 1.3,
            ),
          ),
          Expanded(
            child: Text(
              vertrag.gesellschaft,
              textScaleFactor: 1.3,
            ),
          ),
          Expanded(
            child: Text(
              vertrag.vertragsnummer,
              textScaleFactor: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  FlatButton _buildVorgang(BuildContext context, Vorgang vorgang) {
    return FlatButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VorgangPage(
                    vorgang: vorgang,
                    vertrag: vertragZuVorgang(vorgang),
                  )),
        ),
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              vorgang.zeitpunkt.toString('dd.MM.yyyy HH:mm'),
              textScaleFactor: 1.3,
            ),
          ),
          Expanded(
            child: Text(
              vorgang.titel,
              textScaleFactor: 1.3,
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: BearbeitungsStatusBadge(vorgang.status)),
          ),
        ],
      ),
    );
  }
}
