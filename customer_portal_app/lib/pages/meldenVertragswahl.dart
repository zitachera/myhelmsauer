import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/pages/melden.dart';
import 'package:flutter/material.dart';

class MeldenVertragwahlPage extends StatefulWidget {
  MeldenVertragwahlPage({Key key}) : super(key: key);

  @override
  _MeldenVertragwahlPageState createState() => _MeldenVertragwahlPageState();
}

class _MeldenVertragwahlPageState extends State<MeldenVertragwahlPage> {
  List<Vertrag> vertraege = <Vertrag>[
    Vertrag(
      id: '<uuid-1>',
      sparte: 'KfZ-Versicherung',
      gesellschaft: 'AXA',
      vertragsnummer: '40333844647',
      ablauf: DateTime(2021, 11, 3),
      status: VertragStatus.aktiv,
      beitrag: '750,00 €',
      risiko: 'N HK 334',
      aufnahmeKategorien: <VertragAufnahmeKategorie>[
        VertragAufnahmeKategorie(
          id: 'ausweisVorderseite',
          label: 'Ausweis\u{00AD}vorderseite',
        ),
        VertragAufnahmeKategorie(
          id: 'ausweisRückseite',
          label: 'Ausweis\u{00AD}rückseite',
        ),
        VertragAufnahmeKategorie(
          id: 'führerscheinVorderseite',
          label: 'Führerschein\u{00AD}vorderseite',
        ),
        VertragAufnahmeKategorie(
          id: 'führerscheinrückseite',
          label: 'Führerschein\u{00AD}rückseite',
        ),
        VertragAufnahmeKategorie(
          id: 'grüne karte',
          label: 'Grüne Karte',
        ),
        VertragAufnahmeKategorie(
          id: 'gegnerischesKennzeichen',
          label: 'Gegnerisches Kennzeichen',
        ),
        VertragAufnahmeKategorie(
          id: 'unfall',
          label: 'Unfall\u{00AD}aufnahme',
          max: 3,
        ),
      ],
    ),
    Vertrag(
      id: '<uuid-2>',
      sparte: 'KfZ-Versicherung',
      gesellschaft: 'AXA',
      vertragsnummer: '40333846284',
      ablauf: DateTime(2021, 11, 3),
      status: VertragStatus.aktiv,
      beitrag: '750,00 €',
      risiko: 'N HK 333',
      aufnahmeKategorien: <VertragAufnahmeKategorie>[
        VertragAufnahmeKategorie(
          id: 'ausweisVorderseite',
          label: 'Ausweis\u{00AD}vorderseite',
        ),
        VertragAufnahmeKategorie(
          id: 'ausweisRückseite',
          label: 'Ausweis\u{00AD}rückseite',
        ),
        VertragAufnahmeKategorie(
          id: 'führerscheinVorderseite',
          label: 'Führerschein\u{00AD}vorderseite',
        ),
        VertragAufnahmeKategorie(
          id: 'führerscheinrückseite',
          label: 'Führerschein\u{00AD}rückseite',
        ),
        VertragAufnahmeKategorie(
          id: 'grüneKarte',
          label: 'Grüne Karte',
        ),
        VertragAufnahmeKategorie(
          id: 'gegnerischesKennzeichen',
          label: 'Gegnerisches Kennzeichen',
        ),
        VertragAufnahmeKategorie(
          id: 'unfall',
          label: 'Unfall\u{00AD}aufnahme',
          max: 3,
        ),
      ],
    ),
  ];

  Vertrag vertragZuVorgang(Vorgang vorgang) => vertraege.firstWhere(
        (v) => v.id == vorgang.vertragsID,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Schadenmeldung",
          textScaleFactor: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 14),
          child: Text(
            "Wählen sie den Vertrag zu dem Sie den Schaden melden wollen aus.",
            textScaleFactor: 1.3,
          ),
        ),
        ...vertraege
            .where((v) =>
                v.aufnahmeKategorien != null && v.aufnahmeKategorien.isNotEmpty)
            .map(
              (vertrag) => _buildVertrag(
                context,
                vertrag,
              ),
            ),
      ],
    );
  }

  Widget _buildVertrag(BuildContext context, Vertrag vertrag) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
        color: Colors.black12,
      ),
      margin: EdgeInsets.all(3),
      child: FlatButton(
        padding: EdgeInsets.all(3),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MeldenPage(vertrag: vertrag)),
          ),
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    vertrag.sparte,
                    textScaleFactor: 1.3,
                  ),
                  Text(
                    vertrag.gesellschaft,
                    textScaleFactor: 1.3,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                vertrag.risiko,
                textScaleFactor: 1.3,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
