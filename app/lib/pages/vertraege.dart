import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/pages/vertrag.dart';
import 'package:flutter/material.dart';

class VertraegePage extends StatefulWidget {
  VertraegePage(this.vertraege, {Key key}) : super(key: key);

  final List<Vertrag> vertraege;

  @override
  _VertraegePageState createState() => _VertraegePageState(this.vertraege);
}

class _VertraegePageState extends State<VertraegePage> {
  _VertraegePageState(this.vertraege);
  final List<Vertrag> vertraege;

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
        color: Color.fromRGBO(0, 0, 0, 245),
      ),
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(3),
      child: FlatButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VertragPage(vertrag: vertrag)),
          ),
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              vertrag.sparte,
              textScaleFactor: 1.3,
            ),
            SizedBox(height: 4),
            Text(
              vertrag.gesellschaft,
              textScaleFactor: 1.1,
            ),
            SizedBox(height: 4),
            if (vertrag.risiko != "")
              Text(
                vertrag.risiko,
                textScaleFactor: 1.2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
