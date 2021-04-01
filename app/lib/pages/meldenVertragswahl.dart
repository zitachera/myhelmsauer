import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/pages/melden.dart';
import 'package:flutter/material.dart';

class MeldenVertragwahlPage extends StatefulWidget {
  MeldenVertragwahlPage(this.vertraege, {Key key}) : super(key: key);

  final List<Vertrag> vertraege;

  @override
  _MeldenVertragwahlPageState createState() =>
      _MeldenVertragwahlPageState(vertraege);
}

class _MeldenVertragwahlPageState extends State<MeldenVertragwahlPage> {
  _MeldenVertragwahlPageState(this.vertraege);
  final List<Vertrag> vertraege;

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
        color: Color.fromRGBO(0, 0, 0, 245),
      ),
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(3),
      child: FlatButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MeldenPage(vertrag: vertrag)),
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
