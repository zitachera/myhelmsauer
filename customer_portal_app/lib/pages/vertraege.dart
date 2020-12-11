import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/pages/vertrag.dart';
import 'package:flutter/material.dart';

class VertraegePage extends StatefulWidget {
  VertraegePage({Key key}) : super(key: key);

  @override
  _VertraegePageState createState() => _VertraegePageState();
}

class _VertraegePageState extends State<VertraegePage> {
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
    ),
  ];

  Vertrag vertragZuVorgang(Vorgang vorgang) => vertraege.firstWhere(
        (v) => v.id == vorgang.vertragsID,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            "Vertragsübersicht (${vertraege.length})",
            textScaleFactor: 2,
          ),
        ),
        ...vertraege.map(
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
