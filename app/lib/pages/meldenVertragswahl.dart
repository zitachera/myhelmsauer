import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/service/portal_service.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:customer_portal_app/pages/melden.dart';
import 'package:flutter/material.dart';

class MeldenVertragwahlPage extends StatefulWidget {
  MeldenVertragwahlPage(
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
    final matchs = (String s) => s.toLowerCase().contains(keyword);
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
                (matchs(v.sparte) || matchs(v.risiko) || matchs(v.gesellschaft)))
            .map(
              (vertrag) => _Vertrag(widget: widget, context: context, vertrag: vertrag),
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
}
