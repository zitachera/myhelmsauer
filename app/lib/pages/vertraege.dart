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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 14),
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
      margin: const EdgeInsets.all(3),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        padding: const EdgeInsets.all(5),
        color: const Color.fromRGBO(245, 245, 245, 1),
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
