import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/pages/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HsNestedScrollScaffold(
      title: 'Hemlsauer',
      body: Column(
        children: <Widget>[
          Text(
            "Meine Vorfälle",
            textScaleFactor: 2,
          ),
          _buildVorfall(
            context,
            Vorfall(
              zeitpunkt: LocalDateTime(2020, 01, 20, 9, 50, 10),
              titel: "Fall X",
              status: BearbeitungsStatus.wirdGesendet,
            ),
          ),
          _buildVorfall(
            context,
            Vorfall(
              zeitpunkt: LocalDateTime(2020, 01, 28, 17, 15, 10),
              titel: "Fall Y",
              status: BearbeitungsStatus.inBearbeitung,
            ),
          ),
          FlatButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VertragPage()),
              ),
            },
            child: Text("5 Abgeschlossene Vorfälle"),
          ),
          Text(
            "Meine Verträge",
            textScaleFactor: 2,
          ),
          _buildVertrag(
            context,
            Vertrag(
              name: "Vertrag A",
              beginn: LocalDate(2009, 11, 3),
              versicherer: "AXA",
            ),
          ),
          _buildVertrag(
            context,
            Vertrag(
              name: "Vertrag B",
              beginn: LocalDate(2011, 09, 7),
              versicherer: "HDI",
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
          MaterialPageRoute(builder: (context) => VertragPage()),
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
            child: Text(
              _stati[vorfall.status] ?? "undefined",
              textScaleFactor: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  static const _stati = const {
    BearbeitungsStatus.unvollstaendig: "Entwurf",
    BearbeitungsStatus.wirdGesendet: "Wird Gesendet",
    BearbeitungsStatus.inBearbeitung: "In Bearbeitung",
  };
}
