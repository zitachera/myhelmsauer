/*import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/pages/melden.dart';
import 'package:flutter/material.dart';

class MeldenVertragwahlPage extends StatefulWidget {
  const MeldenVertragwahlPage(
    this.portal, {
    super.key,
    this.bottomNavigationBar,
    this.onRefresh,
  });

  final PortalService portal;

  final Widget? bottomNavigationBar;

  final Future<void> Function()? onRefresh;

  @override
  _MeldenVertragwahlPageState createState() => _MeldenVertragwahlPageState();
}

class _MeldenVertragwahlPageState extends State<MeldenVertragwahlPage> {
  String filter = "";

  @override
  Widget build(BuildContext context) {
    final keyword = filter.toLowerCase();
    bool matchs(String s) => s.toLowerCase().contains(keyword);
    final vertraege = widget.portal.vertraege;

    final content = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 14),
          child: Text(
            "Zu welchen Vertrag möchten Sie einen Schaden melden?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        if (vertraege.length >= 5)
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
              )
            ],
          ),
        ...vertraege
            .where((v) =>
                v.hasSchadenTemplate &&
                (matchs(v.sparte) ||
                    matchs(v.risiko) ||
                    matchs(v.gesellschaft)))
            .map(
              (vertrag) =>
                  _Vertrag(widget: widget, context: context, vertrag: vertrag),
            ),
      ],
    );
    return HsSingleChildScrollScaffold(
      title: "Schadenmeldung",
      body: content,
      onRefresh: widget.onRefresh,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}

class _Vertrag extends StatelessWidget {
  const _Vertrag({
    required this.widget,
    required this.context,
    required this.vertrag,
  });

  final MeldenVertragwahlPage widget;
  final BuildContext context;
  final Vertrag vertrag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      child: MaterialButton(
        padding: EdgeInsets.all(3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        color: const Color.fromRGBO(245, 245, 245, 1),
        elevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeldenPage(
                vertragID: vertrag.id,
                template: vertrag.schadenTemplate,
                portal: widget.portal,
              ),
            ),
          );
        },
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

// version ameloirée du code, avec un design plus moderne et épuré, et une meilleure gestion de l'état pour le champ de recherche.

import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/pages/melden.dart';
import 'package:flutter/material.dart';

class MeldenVertragwahlPage extends StatefulWidget {
  const MeldenVertragwahlPage(
    this.portal, {
    super.key,
    this.bottomNavigationBar,
    this.onRefresh,
  });

  final PortalService portal;
  final Widget? bottomNavigationBar;
  final Future<void> Function()? onRefresh;

  @override
  _MeldenVertragwahlPageState createState() => _MeldenVertragwahlPageState();
}

class _MeldenVertragwahlPageState extends State<MeldenVertragwahlPage> {
  String filter = "";

  static const Color primaryBlue = Color(0xFF0057B8);

  @override
  Widget build(BuildContext context) {
    final keyword = filter.toLowerCase();
    bool matchs(String s) => s.toLowerCase().contains(keyword);

    final vertraege = widget.portal.vertraege;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          "Schadenmeldung",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Wählen Sie einen Vertrag aus",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 16),
        if (vertraege.length >= 5)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextFormField(
              initialValue: filter,
              onChanged: (value) => setState(() => filter = value),
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Verträge durchsuchen",
                border: InputBorder.none,
              ),
            ),
          ),
        const SizedBox(height: 16),
        ...vertraege
            .where((v) =>
                v.hasSchadenTemplate &&
                (matchs(v.sparte) ||
                    matchs(v.risiko) ||
                    matchs(v.gesellschaft)))
            .map(
              (vertrag) => _VertragCard(
                portal: widget.portal,
                vertrag: vertrag,
              ),
            ),
      ],
    );

    return HsSingleChildScrollScaffold(
      title: "Schadenmeldung",
      body: content,
      onRefresh: widget.onRefresh,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}

class _VertragCard extends StatelessWidget {
  const _VertragCard({
    required this.portal,
    required this.vertrag,
  });

  final PortalService portal;
  final Vertrag vertrag;

  static const Color primaryBlue = Color(0xFF0057B8);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeldenPage(
              vertragID: vertrag.id,
              template: vertrag.schadenTemplate,
              portal: portal,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vertrag.sparte,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              vertrag.gesellschaft,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
            if (vertrag.risiko.isNotEmpty) ...[
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  vertrag.risiko,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryBlue,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
