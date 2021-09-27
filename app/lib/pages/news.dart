import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () async {
                await Portal.logout();
                WidgetsBinding.instance!.addPostFrameCallback(
                  (_) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  ),
                );
              },
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
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  "images/Siegel1.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  "images/Siegel2.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
              flex: 1,
            ),
          ],
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
          "Für den Bereich KFZ können Sie schnell und unkompliziert " +
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
