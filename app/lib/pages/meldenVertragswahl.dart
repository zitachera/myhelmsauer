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
}*/

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
  State<MeldenVertragwahlPage> createState() => _MeldenVertragwahlPageState();
}

class _MeldenVertragwahlPageState extends State<MeldenVertragwahlPage> {
  String filter = "";

  static const Color primaryBlue = Color(0xFF0057B8);
  static const Color backgroundColor = Color(0xFFF5F7FB);

  @override
  Widget build(BuildContext context) {
    final keyword = filter.toLowerCase();

    bool matchs(String s) => s.toLowerCase().contains(keyword);

    final vertraege = widget.portal.vertraege;

    final filteredVertraege = vertraege.where(
      (v) =>
          v.hasSchadenTemplate &&
          (matchs(v.sparte) || matchs(v.risiko) || matchs(v.gesellschaft)),
    );

    return HsSingleChildScrollScaffold(
      title: "Schadenmeldung",
      onRefresh: widget.onRefresh,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              const SizedBox(height: 6),

              /*const Text(
                "Schaden melden",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),*/

              Text(
                "Wählen Sie den passenden Vertrag aus",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 22),

              /// SEARCH
              if (vertraege.length >= 5)
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    initialValue: filter,
                    onChanged: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Verträge durchsuchen",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.grey.shade600,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              /// LISTE
              ...filteredVertraege.map(
                (vertrag) => _VertragCard(
                  portal: widget.portal,
                  vertrag: vertrag,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
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

  IconData _iconForContract() {
    final sparte = vertrag.sparte.toLowerCase();

    if (sparte.contains("kfz")) {
      return Icons.directions_car_rounded;
    }

    if (sparte.contains("haus")) {
      return Icons.home_rounded;
    }

    if (sparte.contains("gesund")) {
      return Icons.favorite_rounded;
    }

    if (sparte.contains("reise")) {
      return Icons.flight_takeoff_rounded;
    }

    return Icons.description_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MeldenPage(
                vertragID: vertrag.id,
                template: vertrag.schadenTemplate,
                portal: portal,
              ),
            ),
          );
        },
        child: Container(
          height: 112,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              /// ICON
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  _iconForContract(),
                  color: primaryBlue,
                  size: 28,
                ),
              ),

              const SizedBox(width: 16),

              /// TEXT
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// TITRE
                      Text(
                        vertrag.sparte,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// SOCIETE
                      Text(
                        vertrag.gesellschaft,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// BADGE
                      SizedBox(
                        height: 28,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 150,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              vertrag.risiko.isEmpty
                                  ? "Versicherung"
                                  : vertrag.risiko,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// ARROW
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
