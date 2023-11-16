import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/wertgegenstand.dart';
import 'package:customer_portal_app/service/verzeichnis_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerzeichnisPage extends StatelessWidget {
  VerzeichnisPage({
    super.key,
    required this.viewWertgegenstand,
    this.bottomNavigationBar,
    this.onRefresh,
    required this.erfasseWertgegenstand,
  });

  final void Function(BuildContext, Wertgegenstand) viewWertgegenstand;

  final Widget? bottomNavigationBar;

  final Future<void> Function()? onRefresh;

  final void Function(BuildContext) erfasseWertgegenstand;

  Widget _content(BuildContext context, VerzeichnisProvider vz, Widget? child) {
    var col = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (vz.fehler != null)
            Center(
              child: Text(
                vz.fehler!,
                style: TextStyle(color: helmsauerRot),
              ),
            ),
          if (vz.loading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (vz.updated)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Wertgegenstand aktualisiert.", textScaler: TextScaler.linear(1.2)),
                  SizedBox(height: 8),
                  Text(
                    "Um Ihre Versichererungsumme auf Ihre Wertgegenstände anzupassen, wenden Sie sich bitte an Ihre:n Betreuer:in.",
                  ),
                ],
              ),
            ),
        ]);
    var verzeichnis = vz.verzeichnis;
    if (verzeichnis == null) return col;
    col.children.addAll(
      [
        if (verzeichnis.isEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Keine Wertgegenstände erfasst.",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text("Erfassen Sie Ihre Wertgegenstände, um diese hier zu sehen.")
              ],
            ),
          ),
        ...verzeichnis.map(
          (wertgegenstand) =>
              _Wertgegenstand(verzeichnisPage: this, wertgegenstand: wertgegenstand),
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => erfasseWertgegenstand(context),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
          ),
          icon: const Icon(Icons.add_box),
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Wertgegenstand erfassen',
              softWrap: true,
            ),
          ),
        ),
      ],
    );
    return col;
  }

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: "Wertgegenstandsübersicht",
      body: Consumer<VerzeichnisProvider>(
        builder: _content,
      ),
      onRefresh: onRefresh,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class _Wertgegenstand extends StatelessWidget {
  const _Wertgegenstand({
    required this.verzeichnisPage,
    required this.wertgegenstand,
  });

  final VerzeichnisPage verzeichnisPage;
  final Wertgegenstand wertgegenstand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        padding: const EdgeInsets.all(5),
        elevation: 0,
        color: const Color.fromRGBO(245, 245, 245, 1),
        onPressed: () => verzeichnisPage.viewWertgegenstand(context, wertgegenstand),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.66,
              child: wertgegenstand.image.isEmpty
                  ? FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.image, color: blauGrau),
                      ),
                    )
                  : Image.memory(
                      wertgegenstand.image,
                      fit: BoxFit.cover,
                    ),
            ),
            Text(
              wertgegenstand.name,
              textScaler: TextScaler.linear(1.1),
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 4),
            Text(
              _formatBetrag(wertgegenstand.wert),
              textScaler: TextScaler.linear(0.9),
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  String _formatBetrag(double betrag) {
    return betrag.toStringAsFixed(2).replaceAll(".", ",") + " €";
  }
}
