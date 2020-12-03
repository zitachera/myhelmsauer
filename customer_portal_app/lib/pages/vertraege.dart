import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/pages/vertrag.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Vertrag> vertraege = <Vertrag>[
    Vertrag(
      id: '<uuid-1>',
      sparte: 'Kfz-Versicherung',
      gesellschaft: 'AXA',
      vertragsnummer: '123',
      ablauf: DateTime(2029, 11, 3),
      status: VertragStatus.aktiv,
      beitrag: '20,00 €',
      risiko: '??',
    ),
    Vertrag(
      id: '<uuid-2>',
      sparte: 'Kfz-Versicherung',
      gesellschaft: 'HDI',
      vertragsnummer: '456',
      ablauf: DateTime(2029, 11, 3),
      status: VertragStatus.aktiv,
      beitrag: '55,00 €',
      risiko: 'N XM 333',
    ),
  ];

  Vertrag vertragZuVorgang(Vorgang vorgang) => vertraege.firstWhere(
        (v) => v.id == vorgang.vertragsID,
      );

  @override
  Widget build(BuildContext context) {
    return HsNestedScrollScaffold(
      title: 'Helmsauer',
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
}
