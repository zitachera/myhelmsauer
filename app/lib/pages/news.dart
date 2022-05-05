import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class NewsPage extends StatefulWidget {
  NewsPage({
    Key? key,
    required this.bottomNavigationBar,
    required this.onRefresh,
    required this.logout,
  }) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();

  final Widget bottomNavigationBar;

  final Future<void> Function() onRefresh;

  final void Function(BuildContext) logout;
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () => widget.logout(context),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Log out",
                      style: TextStyle(
                        color: helmsauerRot,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.logout,
                    color: helmsauerRot,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/siegel/1.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/siegel/2.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/siegel/3.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/siegel/4.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              flex: 1,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.zero,
            color: Color.fromARGB(255, 241, 244, 247),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: new AppBar(
                    title: Text("Cyberkriminalität"),
                  ),
                  backgroundColor: Colors.grey,
                  body: PdfViewer.openAsset("images/cyber.pdf"),
                ),
              ),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "images/cyber.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        "Cyberkriminalität – so schützen Sie Ihr Unternehmen!",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        _faqTop(
          SvgPicture.asset(
            "images/menu/aktuelles.svg",
            color: Colors.white,
          ),
          "FAQ",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/smartphone.svg",
            color: helmsauerBlau,
          ),
          "Auf der myHelmsauer Startseite finden Sie im Newsbereich wechselnde " +
              "Artikel zu interessanten Versicherungsthemen.",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/vertrag.svg",
            color: helmsauerBlau,
          ),
          "In Ihrer Vertragsübersicht haben Sie Zugriff auf " +
              "all Ihre bestehenden Versicherungsverträge und " +
              "finden nähere Informationen dazu.",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/schaden.svg",
            color: helmsauerBlau,
          ),
          "Für einige Sparten können Sie schnell und unkompliziert " +
              "eine Schadenmeldung vornehmen. " +
              "Weitere Sparten werden zeitnah hinzugefügt.",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/kontakt.svg",
            color: helmsauerBlau,
          ),
          "Über verschiedene Wege können Sie direkt mit " +
              "uns in Verbindung treten. Wann, wo und so oft " +
              "Sie wollen. Wir sind gerne für Sie da!",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/idee.svg",
            color: helmsauerBlau,
          ),
          "Viele Zusatzfunktionen werden Ihnen bald zur " +
              "Verfügung stehen. Wir arbeiten permanent an " +
              "der App um Ihnen den bestmöglichen Service " +
              "zu bieten.",
        ),
        _faqBottom(
          SvgPicture.asset(
            "images/menu/kontakt.svg",
            color: helmsauerBlau,
          ),
          "Bei Fragen oder Anregungen wenden Sie sich gerne " +
              "an uns. Sie erreichen uns im Reiter Kontakt.",
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        title: Column(
          children: [
            Text(
              "Willkommen bei",
              style: TextStyle(
                fontFamily: 'FuturaRound',
                fontWeight: FontWeight.w300,
                fontSize: 24,
              ),
            ),
            Text(
              "myHELMSAUER",
              style: TextStyle(
                fontFamily: 'FuturaRound',
                fontWeight: FontWeight.w500,
                fontSize: 36,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: widget.onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                child: content,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  Widget _faqTop(Widget icon, String text) => Container(
        decoration: new BoxDecoration(
          color: helmsauerBlau,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        margin: EdgeInsets.all(2),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: FittedBox(
                  child: icon,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _faqMiddle(Widget icon, String text) => Container(
        decoration: new BoxDecoration(
          color: Color.fromARGB(255, 241, 244, 247),
        ),
        margin: EdgeInsets.all(2),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: FittedBox(
                  child: icon,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: dunklesBlau,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _faqBottom(Widget icon, String text) => Container(
        decoration: new BoxDecoration(
          color: Color.fromARGB(255, 241, 244, 247),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        margin: EdgeInsets.all(2),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: FittedBox(
                  child: icon,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: dunklesBlau,
                  ),
                  maxLines: 50,
                ),
              ),
            ),
          ],
        ),
      );
}
