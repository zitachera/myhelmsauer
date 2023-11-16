import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/components/svgicon.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter/material.dart';

class VertragPage extends StatelessWidget {
  VertragPage({
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
                        child: Text("Neue ${template.name}", textScaler: TextScaler.linear(1.3)),
                      ),
                    ],
                  ),
                  onPressed: () => viewMeldeDialog(context, vertrag.id, template),
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
                        child: Text(dokument.titel, textScaler: TextScaler.linear(1.3)),
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
            child: Text(
              caption + ":",
            ),
            flex: 2,
          ),
          Expanded(
            child: Text(
              value,
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
