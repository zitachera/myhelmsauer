import 'package:customer_portal_app/model/types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BearbeitungsStatusBadge extends StatelessWidget {
  BearbeitungsStatusBadge(this.status, {Key key}) : super(key: key);

  final BearbeitungsStatus status;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.5),
          child: Text(
            const <BearbeitungsStatus, String>{
                  BearbeitungsStatus.unvollstaendig: "Entwurf",
                  BearbeitungsStatus.wirdGesendet: "Wird Gesendet",
                  BearbeitungsStatus.inBearbeitung: "In Bearbeitung",
                  BearbeitungsStatus.abgeschlossen: "Abgeschlossen",
                }[status] ??
                "Unbekannter Status",
            textScaleFactor: 1.1,
          ),
        ),
      ),
    );
  }
}
