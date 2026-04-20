// ignore_for_file: unused_import

/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/components/svgicon.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter/material.dart';

class VertragPage extends StatelessWidget {
  const VertragPage({
    super.key,
    required this.viewDocument,
    required this.viewMeldeDialog,
    required this.vertrag,
  });

  final Vertrag vertrag;

  final void Function(BuildContext, VertragDokument) viewDocument;

  final void Function(BuildContext, String, MeldeTemplate) viewMeldeDialog;

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Vertragsinfo',
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _InfoLine(
                caption: "Sparte",
                value: vertrag.sparte,
              ),
              _InfoLine(
                caption: "VSNR",
                value: vertrag.vertragsnummer,
              ),
              _InfoLine(
                caption: "Gesellschaft",
                value: vertrag.gesellschaft,
              ),
              _InfoLine(
                caption: "Ablauf",
                value: dateFormat.format(vertrag.ablauf),
              ),
              _InfoLine(
                caption: "Beitrag",
                value: vertrag.beitrag,
              ),
              _InfoLine(
                caption: "versichertes Risiko",
                value: vertrag.risiko,
              ),
              for (var template in vertrag.meldeTemplates)
                MaterialButton(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 12.0),
                        child: SvgIcon("images/menu/kontakt.svg"),
                      ),
                      Expanded(
                        child: Text("Neue ${template.name}",
                            textScaler: TextScaler.linear(1.3)),
                      ),
                    ],
                  ),
                  onPressed: () =>
                      viewMeldeDialog(context, vertrag.id, template),
                ),
              for (var dokument in vertrag.dokumente)
                MaterialButton(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.text_snippet),
                      ),
                      Expanded(
                        child: Text(dokument.titel,
                            textScaler: TextScaler.linear(1.3)),
                      ),
                    ],
                  ),
                  onPressed: () => viewDocument(context, dokument),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.caption,
    required this.value,
  });

  final String caption;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 250),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              caption + ":",
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}*/

/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/components/svgicon.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VertragPage extends StatelessWidget {
  const VertragPage({
    super.key,
    required this.viewDocument,
    required this.viewMeldeDialog,
    required this.vertrag,
  });

  final Vertrag vertrag;
  final void Function(BuildContext, VertragDokument) viewDocument;
  final void Function(BuildContext, String, MeldeTemplate) viewMeldeDialog;

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Vertragsinfo',
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // ⭐ FAVORI
            StatefulBuilder(
              builder: (context, setState) {
                SharedPreferences.getInstance().then((prefs) {
                  vertrag.isFavorite =
                      prefs.getBool('favorit_${vertrag.id}') ?? false;
                });

                return Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      vertrag.isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      setState(() {
                        vertrag.isFavorite = !vertrag.isFavorite;
                        prefs.setBool(
                            'favorit_${vertrag.id}', vertrag.isFavorite);
                      });
                    },
                  ),
                );
              },
            ),

            _InfoLine(caption: "Sparte", value: vertrag.sparte),
            _InfoLine(caption: "VSNR", value: vertrag.vertragsnummer),
            _InfoLine(caption: "Gesellschaft", value: vertrag.gesellschaft),
            _InfoLine(
                caption: "Ablauf", value: dateFormat.format(vertrag.ablauf)),
            _InfoLine(caption: "Beitrag", value: vertrag.beitrag),
            _InfoLine(caption: "Risiko", value: vertrag.risiko),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.caption, required this.value});

  final String caption;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(3),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(flex: 2, child: Text("$caption:")),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}*/

/*import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/components/svgicon.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VertragPage extends StatelessWidget {
  const VertragPage({
    super.key,
    required this.viewDocument,
    required this.viewMeldeDialog,
    required this.vertrag,
  });

  final Vertrag vertrag;
  final void Function(BuildContext, VertragDokument) viewDocument;
  final void Function(BuildContext, String, MeldeTemplate) viewMeldeDialog;

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Vertragsinfo',
      body: Padding(
        padding: const EdgeInsets.all(20), // 🔹 PLUS D’AIR (modifié)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ⭐ FAVORI MODERNE
            StatefulBuilder(
              builder: (context, setState) {
                SharedPreferences.getInstance().then((prefs) {
                  vertrag.isFavorite =
                      prefs.getBool('favorit_${vertrag.id}') ?? false;
                });

                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          Colors.grey.shade100, // 🔹 fond léger au lieu de rien
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        vertrag.isFavorite ? Icons.star : Icons.star_border,
                        color: vertrag.isFavorite
                            ? helmsauerBlau // 🔹 BLEU APP AU LIEU DE JAUNE
                            : Colors.grey.shade400,
                        size: 28, // 🔹 un peu plus grande
                      ),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        setState(() {
                          vertrag.isFavorite = !vertrag.isFavorite;
                          prefs.setBool(
                              'favorit_${vertrag.id}', vertrag.isFavorite);
                        });
                      },
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // 📦 CARTE PRINCIPALE MODERNE
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // 🔹 BLANC AU LIEU DE NOIR
                borderRadius:
                    BorderRadius.circular(20), // 🔹 plus arrondi = moderne
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // 🔹 ombre subtile
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _InfoLine(caption: "Sparte", value: vertrag.sparte),
                  _InfoLine(caption: "VSNR", value: vertrag.vertragsnummer),
                  _InfoLine(
                      caption: "Gesellschaft", value: vertrag.gesellschaft),
                  _InfoLine(
                      caption: "Ablauf",
                      value: dateFormat.format(vertrag.ablauf)),
                  _InfoLine(caption: "Beitrag", value: vertrag.beitrag),
                  _InfoLine(caption: "Risiko", value: vertrag.risiko),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.caption, required this.value});

  final String caption;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10), // 🔹 plus respirant
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 CAPTION PLUS DISCRET (plus bleu moche)
          Expanded(
            flex: 2,
            child: Text(
              caption,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600, // 🔹 gris élégant
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // 🔹 VALEUR PLUS IMPORTANTE VISUELLEMENT
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:share_plus/share_plus.dart";

class VertragPage extends StatefulWidget {
  const VertragPage({
    super.key,
    required this.viewDocument,
    required this.viewMeldeDialog,
    required this.vertrag,
  });

  final Vertrag vertrag;
  final void Function(BuildContext, VertragDokument) viewDocument;
  final void Function(BuildContext, String, MeldeTemplate) viewMeldeDialog;

  @override
  State<VertragPage> createState() => _VertragPageState();
}

class _VertragPageState extends State<VertragPage> {
  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  ///  Charge l'état favori depuis SharedPreferences
  Future<void> _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.vertrag.isFavorite =
          prefs.getBool('favorit_${widget.vertrag.id}') ?? false;
    });
  }

  ///  Toggle favori (étoile bleue)
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.vertrag.isFavorite = !widget.vertrag.isFavorite;
      prefs.setBool(
        'favorit_${widget.vertrag.id}',
        widget.vertrag.isFavorite,
      );
    });
  }

  ///Partage du résumé du contrat
  void _shareVertrag() {
    final text = '''
Vertrag: ${widget.vertrag.sparte}
Gesellschaft: ${widget.vertrag.gesellschaft}
VSNR: ${widget.vertrag.vertragsnummer}
Ablauf: ${dateFormat.format(widget.vertrag.ablauf)}
Beitrag: ${widget.vertrag.beitrag}
Risiko: ${widget.vertrag.risiko}
''';

    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    return HsSingleChildScrollScaffold(
      title: 'Vertragsinfo',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ///  HEADER ACTIONS (Favori + Partage)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  tooltip: 'Vertrag teilen',
                  icon: const Icon(Icons.share_outlined),
                  color: helmsauerBlau,
                  onPressed: _shareVertrag,
                ),
                IconButton(
                  tooltip: 'Favorit',
                  icon: Icon(
                    widget.vertrag.isFavorite ? Icons.star : Icons.star_border,
                  ),
                  color: helmsauerBlau,
                  onPressed: _toggleFavorite,
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// 🔹 BLOC UNIQUE MODERNE (facile à partager / lire)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 246, 242, 242)
                        .withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITRE
                  Text(
                    widget.vertrag.sparte,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  _InfoRow(
                    label: 'Gesellschaft',
                    value: widget.vertrag.gesellschaft,
                  ),
                  _InfoRow(
                    label: 'VSNR',
                    value: widget.vertrag.vertragsnummer,
                  ),
                  _InfoRow(
                    label: 'Ablauf',
                    value: dateFormat.format(widget.vertrag.ablauf),
                  ),
                  _InfoRow(
                    label: 'Beitrag',
                    value: widget.vertrag.beitrag,
                  ),
                  if (widget.vertrag.risiko.isNotEmpty)
                    _InfoRow(
                      label: 'Risiko',
                      value: widget.vertrag.risiko,
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 BOUTON ACTION (exemple futur documents)
            ElevatedButton.icon(
              onPressed: () {
                // 👉 ici tu pourras brancher un partage de documents PDF
              },
              icon: const Icon(Icons.description_outlined),
              label: const Text('Vertragsdokumente'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Ligne d'information propre & moderne
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color.fromARGB(255, 252, 250, 250),
                  ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
