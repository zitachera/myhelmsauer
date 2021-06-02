import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/model/vorgang.dart';
import 'package:customer_portal_app/pages/vertrag.dart';
import 'package:flutter/material.dart';

class VertraegePage extends StatelessWidget {
  VertraegePage(this.portal, this.vertraege, {Key? key}) : super(key: key);

  final Portal portal;
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
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Vertragsübersicht",
                  textScaleFactor: 2,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: helmsauerBlue.withAlpha(128),
                ),
                padding: EdgeInsets.all(4),
                height: 35,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FittedBox(
                    child: Text(
                      "${vertraege.length}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
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
        elevation: 0,
        color: const Color.fromRGBO(245, 245, 245, 1),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VertragPage(portal, vertrag: vertrag)),
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
              vertrag.gesellschaft + "d",
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
