import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/components/scaffolds.dart';
import 'package:customer_portal_app/model/vertrag.dart';
import 'package:flutter/material.dart';

class VertraegePage extends StatefulWidget {
  VertraegePage(
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
    final matchs = (String s) => s.toLowerCase().contains(keyword);
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
            .where((v) => matchs(v.sparte) || matchs(v.risiko) || matchs(v.gesellschaft))
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
}
