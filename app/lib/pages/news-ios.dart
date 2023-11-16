import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class IOSNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
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
                        style: Theme.of(context).textTheme.displayMedium,
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
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          "FAQ",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/smartphone.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "Auf der myHelmsauer Startseite finden Sie im Newsbereich wechselnde " +
              "Artikel zu interessanten Versicherungsthemen.",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/vertrag.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "In Ihrer Vertragsübersicht haben Sie Zugriff auf " +
              "all Ihre bestehenden Versicherungsverträge und " +
              "finden nähere Informationen dazu.",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/schaden.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "Für einige Sparten können Sie schnell und unkompliziert " +
              "eine Schadenmeldung vornehmen. " +
              "Weitere Sparten werden zeitnah hinzugefügt.",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/kontakt.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "Über verschiedene Wege können Sie direkt mit " +
              "uns in Verbindung treten. Wann, wo und so oft " +
              "Sie wollen. Wir sind gerne für Sie da!",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/idee.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "Viele Zusatzfunktionen werden Ihnen bald zur " +
              "Verfügung stehen. Wir arbeiten permanent an " +
              "der App um Ihnen den bestmöglichen Service " +
              "zu bieten.",
        ),
        _faqBottom(
          SvgPicture.asset(
            "images/menu/kontakt.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "Bei Fragen oder Anregungen wenden Sie sich gerne " +
              "an uns. Sie erreichen uns im Reiter Kontakt.",
        ),
      ],
    );
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      child: content,
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
