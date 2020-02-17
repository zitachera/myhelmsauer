import 'package:customer_portal_app/model/types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BearbeitungsStatusBadge extends StatelessWidget {
  BearbeitungsStatusBadge(this.status, {Key key}) : super(key: key);

  final BearbeitungsStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(11)),
        color: const <BearbeitungsStatus, Color>{
              BearbeitungsStatus.inBearbeitung:
                  Color.fromARGB(255, 200, 200, 0),
              BearbeitungsStatus.abgeschlossen: Color.fromARGB(255, 0, 200, 0),
            }[status] ??
            Colors.black54,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 1.5,
        ),
        child: Text(
          const <BearbeitungsStatus, String>{
                BearbeitungsStatus.unvollstaendig: "Entwurf",
                BearbeitungsStatus.wirdGesendet: "Wird Gesendet",
                BearbeitungsStatus.inBearbeitung: "In Bearbeitung",
                BearbeitungsStatus.abgeschlossen: "Abgeschlossen",
              }[status] ??
              "Unbekannter Status",
          textScaleFactor: 1,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
