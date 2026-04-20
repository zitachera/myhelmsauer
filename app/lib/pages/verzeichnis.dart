/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/wertgegenstand.dart';
import 'package:customer_portal_app/service/verzeichnis_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerzeichnisPage extends StatelessWidget {
  const VerzeichnisPage({
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
                  Text("Wertgegenstand aktualisiert.",
                      textScaler: TextScaler.linear(1.2)),
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
                Text(
                    "Erfassen Sie Ihre Wertgegenstände, um diese hier zu sehen.")
              ],
            ),
          ),
        ...verzeichnis.map(
          (wertgegenstand) => _Wertgegenstand(
              verzeichnisPage: this, wertgegenstand: wertgegenstand),
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
        onPressed: () =>
            verzeichnisPage.viewWertgegenstand(context, wertgegenstand),
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
    return "${betrag.toStringAsFixed(2).replaceAll(".", ",")} €";
  }
}*/

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/wertgegenstand.dart';
import 'package:customer_portal_app/service/verzeichnis_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerzeichnisPage extends StatelessWidget {
  const VerzeichnisPage({
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
    // FOND BLANC GLOBAL PLUS PREMIUM
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  MESSAGE ERREUR MODERNE
          if (vz.fehler != null)
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: helmsauerRot.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                vz.fehler!,
                style: TextStyle(
                  color: helmsauerRot,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          //  LOADING PLUS PROPRE
          if (vz.loading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            ),

          //  MESSAGE UPDATE MODERNE
          if (vz.updated)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: helmsauerBlau.withOpacity(0.06),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Wertgegenstand aktualisiert.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Um Ihre Versichererungsumme anzupassen, wenden Sie sich bitte an Ihre:n Betreuer:in.",
                  ),
                ],
              ),
            ),

          // LISTE
          if (vz.verzeichnis != null) ..._buildList(context, vz.verzeichnis!),
        ],
      ),
    );
  }

  List<Widget> _buildList(
      BuildContext context, List<Wertgegenstand> verzeichnis) {
    if (verzeichnis.isEmpty) {
      // ETAT VIDE PLUS MODERNE
      return [
        const SizedBox(height: 40),
        Center(
          child: Column(
            children: [
              Icon(Icons.inventory_2_outlined,
                  size: 60, color: Colors.grey.shade400),
              const SizedBox(height: 20),
              const Text(
                "Keine Wertgegenstände erfasst",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Erfassen Sie Ihre Wertgegenstände,\num diese hier zu sehen.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ];
    }

    return [
      ...verzeichnis.map(
        (wertgegenstand) => _Wertgegenstand(
          verzeichnisPage: this,
          wertgegenstand: wertgegenstand,
        ),
      ),
      const SizedBox(height: 20),

      //  BOUTON MODERNE BLEU
      ElevatedButton.icon(
        onPressed: () => erfasseWertgegenstand(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: helmsauerBlau,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 3,
        ),
        icon: const Icon(Icons.add),
        label: const Text(
          'Wertgegenstand erfassen',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      const SizedBox(height: 30),
    ];
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
    return GestureDetector(
      onTap: () => verzeichnisPage.viewWertgegenstand(context, wertgegenstand),

      // CARD MODERNE AU LIEU DU BOUTON GRIS
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22), // plus arrondi
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //  IMAGE AVEC COINS ARRONDIS
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(22)),
              child: AspectRatio(
                aspectRatio: 1.66,
                child: wertgegenstand.image.isEmpty
                    ? Container(
                        color: Colors.grey.shade100,
                        child: Icon(Icons.image,
                            size: 50, color: Colors.grey.shade400),
                      )
                    : Image.memory(
                        wertgegenstand.image,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            //  CONTENU TEXTE PLUS STRUCTURÉ
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NOM IMPORTANT
                  Text(
                    wertgegenstand.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // PRIX EN BLEU APP
                  Text(
                    _formatBetrag(wertgegenstand.wert),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: helmsauerBlau,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatBetrag(double betrag) {
    return "${betrag.toStringAsFixed(2).replaceAll(".", ",")} €";
  }
}
