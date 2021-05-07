import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/pages/melden.dart';
import 'package:flutter/material.dart';

class MeldenVertragwahlPage extends StatefulWidget {
  MeldenVertragwahlPage(this.portal, {Key key}) : super(key: key);

  final Portal portal;

  @override
  _MeldenVertragwahlPageState createState() =>
      _MeldenVertragwahlPageState(portal.vertraege, portal);
}

class _MeldenVertragwahlPageState extends State<MeldenVertragwahlPage> {
  _MeldenVertragwahlPageState(this.vertraege, this.portal);
  final List<Vertrag> vertraege;

  final Portal portal;

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
      margin: EdgeInsets.all(3),
      child: MaterialButton(
        padding: EdgeInsets.all(3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        color: const Color.fromRGBO(245, 245, 245, 1),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MeldenPage(
                      vertrag: vertrag,
                      portal: portal,
                    )),
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
