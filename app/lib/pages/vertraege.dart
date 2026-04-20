/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter/material.dart';

class VertraegePage extends StatefulWidget {
  const VertraegePage(
    this.vertraege, {
    super.key,
    required this.viewVertrag,
    this.bottomNavigationBar,
    this.onRefresh,
    required this.erfasseFremdvertrag,
  });

  final void Function(BuildContext, Vertrag) viewVertrag;
  final List<Vertrag> vertraege;

  final Widget? bottomNavigationBar;

  final Future<void> Function()? onRefresh;

  final void Function(BuildContext) erfasseFremdvertrag;

  @override
  State<VertraegePage> createState() => _VertraegePageState();
}

class _VertraegePageState extends State<VertraegePage> {
  String filter = "";

  @override
  Widget build(BuildContext context) {
    final keyword = filter.toLowerCase();
    bool matchs(String s) => s.toLowerCase().contains(keyword);
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
            Expanded(
              child: TextFormField(
                initialValue: filter,
                onChanged: (value) => setState(() {
                  filter = value;
                }),
                decoration: InputDecoration(hintText: "Verträge durchsuchen"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: helmsauerBlau.withAlpha(128),
              ),
              padding: const EdgeInsets.all(4),
              margin: EdgeInsets.only(left: 6),
              height: 35,
              child: AspectRatio(
                aspectRatio: 1,
                child: FittedBox(
                  child: Text(
                    "${widget.vertraege.length}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
        ...widget.vertraege
            .where((v) =>
                matchs(v.sparte) || matchs(v.risiko) || matchs(v.gesellschaft))
            .map(
              (vertrag) => _Vertrag(vertraegePage: widget, vertrag: vertrag),
            ),
        SizedBox(height: 20),
        OutlinedButton(
          onPressed: () => widget.erfasseFremdvertrag(context),
          child: Row(
            children: [
              const Icon(Icons.add_moderator),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Nicht von der Helmsauer-Gruppe betreuten Versicherungsvertrag für elektronische Kundenakte erfassen (Fremdvertrag)',
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return HsSingleChildScrollScaffold(
      title: "Vertragsübersicht",
      body: content,
      onRefresh: widget.onRefresh,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}

class _Vertrag extends StatelessWidget {
  const _Vertrag({
    required this.vertraegePage,
    required this.vertrag,
  });

  final VertraegePage vertraegePage;
  final Vertrag vertrag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        padding: const EdgeInsets.all(5),
        elevation: 0,
        color: primaerGrau,
        onPressed: () => vertraegePage.viewVertrag(context, vertrag),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              vertrag.sparte,
              textScaler: TextScaler.linear(1.1),
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 4),
            Text(
              vertrag.gesellschaft,
              textScaler: TextScaler.linear(0.9),
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 4),
            if (vertrag.risiko != "")
              Text(
                vertrag.risiko,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
          ],
        ),
      ),
    );
  }
}*/

/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VertraegePage extends StatefulWidget {
  const VertraegePage(
    this.vertraege, {
    super.key,
    required this.viewVertrag,
    this.bottomNavigationBar,
    this.onRefresh,
    required this.erfasseFremdvertrag,
  });

  final void Function(BuildContext, Vertrag) viewVertrag;
  final List<Vertrag> vertraege;
  final Widget? bottomNavigationBar;
  final Future<void> Function()? onRefresh;
  final void Function(BuildContext) erfasseFremdvertrag;

  @override
  State<VertraegePage> createState() => _VertraegePageState();
}

class _VertraegePageState extends State<VertraegePage> {
  String filter = "";

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (final v in widget.vertraege) {
        v.isFavorite = prefs.getBool('favorit_${v.id}') ?? false;
      }
    });
  }

  Future<void> _toggleFavorite(Vertrag vertrag) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      vertrag.isFavorite = !vertrag.isFavorite;
      prefs.setBool('favorit_${vertrag.id}', vertrag.isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyword = filter.toLowerCase();
    bool matchs(String s) => s.toLowerCase().contains(keyword);

    // ⭐ Favoris en premier
    final sorted = [...widget.vertraege]
      ..sort((a, b) => b.isFavorite ? 1 : -1);

    final filtered = sorted.where(
      (v) =>
          matchs(v.sparte) ||
          matchs(v.risiko) ||
          matchs(v.gesellschaft),
    );

    return HsSingleChildScrollScaffold(
      title: "Vertragsübersicht",
      onRefresh: widget.onRefresh,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.search),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: filter,
                  onChanged: (v) => setState(() => filter = v),
                  decoration:
                      const InputDecoration(hintText: "Verträge durchsuchen"),
                ),
              ),
            ],
          ),

          ...filtered.map(
            (vertrag) => _Vertrag(
              vertrag: vertrag,
              onOpen: () => widget.viewVertrag(context, vertrag),
              onToggleFavorite: () => _toggleFavorite(vertrag),
            ),
          ),

          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () => widget.erfasseFremdvertrag(context),
            child: const Text("Fremdvertrag erfassen"),
          ),
        ],
      ),
    );
  }
}

class _Vertrag extends StatelessWidget {
  const _Vertrag({
    required this.vertrag,
    required this.onOpen,
    required this.onToggleFavorite,
  });

  final Vertrag vertrag;
  final VoidCallback onOpen;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      child: MaterialButton(
        color: primaerGrau,
        onPressed: onOpen,
        child: Row(
          children: [
            // ⭐ ÉTOILE CLIQUABLE
            IconButton(
              icon: Icon(
                vertrag.isFavorite ? Icons.star : Icons.star_border,
                color: vertrag.isFavorite ? Colors.yellow : Colors.grey,
              ),
              onPressed: onToggleFavorite,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vertrag.sparte,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vertrag.gesellschaft,
                    style: const TextStyle(fontSize: 12),
                  ),
                  if (vertrag.risiko.isNotEmpty)
                    Text(
                      vertrag.risiko,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VertraegePage extends StatefulWidget {
  const VertraegePage(
    this.vertraege, {
    super.key,
    required this.viewVertrag,
    this.bottomNavigationBar,
    this.onRefresh,
    required this.erfasseFremdvertrag,
  });

  final void Function(BuildContext, Vertrag) viewVertrag;
  final List<Vertrag> vertraege;
  final Widget? bottomNavigationBar;
  final Future<void> Function()? onRefresh;
  final void Function(BuildContext) erfasseFremdvertrag;

  @override
  State<VertraegePage> createState() => _VertraegePageState();
}

class _VertraegePageState extends State<VertraegePage> {
  String filter = "";

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (final v in widget.vertraege) {
        v.isFavorite = prefs.getBool('favorit_${v.id}') ?? false;
      }
    });
  }

  Future<void> _toggleFavorite(Vertrag vertrag) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      vertrag.isFavorite = !vertrag.isFavorite;
      prefs.setBool('favorit_${vertrag.id}', vertrag.isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyword = filter.toLowerCase();
    bool matchs(String s) => s.toLowerCase().contains(keyword);

    // Favoris toujours en premier (amélioré)
    final sorted = [...widget.vertraege]..sort(
        (a, b) => b.isFavorite.toString().compareTo(a.isFavorite.toString()));

    final filtered = sorted.where(
      (v) => matchs(v.sparte) || matchs(v.risiko) || matchs(v.gesellschaft),
    );

    return HsSingleChildScrollScaffold(
      title: "Vertragsübersicht",
      onRefresh: widget.onRefresh,
      bottomNavigationBar: widget.bottomNavigationBar,

      //  FOND BLANC MODERNE
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            //  BARRE DE RECHERCHE MODERNE
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 255, 255, 255), // gris très clair moderne
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search,
                        color: const Color.fromARGB(255, 254, 253, 253)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        initialValue: filter,
                        onChanged: (v) => setState(() => filter = v),
                        decoration: const InputDecoration(
                          hintText: "Verträge durchsuchen",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //  LISTE MODERNE
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  ...filtered.map(
                    (vertrag) => _Vertrag(
                      vertrag: vertrag,
                      onOpen: () => widget.viewVertrag(context, vertrag),
                      onToggleFavorite: () => _toggleFavorite(vertrag),
                    ),
                  ),

                  const SizedBox(height: 20),

                  //  BOUTON MODERNE OUTLINED
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: helmsauerBlau), // 🔹 bleu app
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => widget.erfasseFremdvertrag(context),
                    child: Text(
                      "Fremdvertrag erfassen",
                      style: TextStyle(
                        color: helmsauerBlau,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Vertrag extends StatelessWidget {
  const _Vertrag({
    required this.vertrag,
    required this.onOpen,
    required this.onToggleFavorite,
  });

  final Vertrag vertrag;
  final VoidCallback onOpen;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpen,

      // CARD MODERNE AU LIEU DU BOUTON GRIS
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white, // 🔹 blanc premium
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            //  ÉTOILE BLEUE MODERNE
            GestureDetector(
              onTap: onToggleFavorite,
              child: Icon(
                vertrag.isFavorite ? Icons.star : Icons.star_border,
                color: vertrag.isFavorite
                    ? helmsauerBlau // 🔹 BLEU AU LIEU DE JAUNE
                    : Colors.grey.shade400,
                size: 26,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITRE PRINCIPAL
                  Text(
                    vertrag.sparte,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // SOCIÉTÉ EN GRIS ÉLÉGANT
                  Text(
                    vertrag.gesellschaft,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  if (vertrag.risiko.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        vertrag.risiko,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            //  CHEVRON MODERNE
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
