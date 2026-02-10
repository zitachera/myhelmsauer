/*import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class IOSNews extends StatelessWidget {
  const IOSNews({super.key});

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/siegel/1.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/siegel/2.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/siegel/3.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/siegel/4.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
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
                  appBar: AppBar(
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
          "Auf der myHelmsauer Startseite finden Sie im Newsbereich wechselnde "
          "Artikel zu interessanten Versicherungsthemen.",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/vertrag.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "In Ihrer Vertragsübersicht haben Sie Zugriff auf "
                  "all Ihre bestehenden Versicherungsverträge und " +
              "finden nähere Informationen dazu.",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/schaden.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "Für einige Sparten können Sie schnell und unkompliziert "
                  "eine Schadenmeldung vornehmen. " +
              "Weitere Sparten werden zeitnah hinzugefügt.",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/kontakt.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "Über verschiedene Wege können Sie direkt mit "
                  "uns in Verbindung treten. Wann, wo und so oft " +
              "Sie wollen. Wir sind gerne für Sie da!",
        ),
        _faqMiddle(
          SvgPicture.asset(
            "images/menu/idee.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "Viele Zusatzfunktionen werden Ihnen bald zur "
                  "Verfügung stehen. Wir arbeiten permanent an " +
              "der App um Ihnen den bestmöglichen Service " +
              "zu bieten.",
        ),
        _faqBottom(
          SvgPicture.asset(
            "images/menu/kontakt.svg",
            colorFilter: ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          "Bei Fragen oder Anregungen wenden Sie sich gerne "
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
        decoration: BoxDecoration(
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
                  fit: BoxFit.fitWidth,
                  child: icon,
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
        decoration: BoxDecoration(
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
                  fit: BoxFit.fitWidth,
                  child: icon,
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
        decoration: BoxDecoration(
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
                  fit: BoxFit.fitWidth,
                  child: icon,
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
*/

import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class IOSNews extends StatelessWidget {
  const IOSNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // 🔹 Padding global mobile-friendly
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 🔹 Header moderne avec badges
          //_HeaderCard(),

          const SizedBox(height: 20),

          // 🔹 Carte news cliquable
          _NewsCard(context),

          const SizedBox(height: 30),

          // 🔹 Section FAQ
          _SectionTitle("FAQ"),

          _FaqItem(
            icon: "images/menu/smartphone.svg",
            text:
                "Auf der Startseite finden Sie regelmäßig neue Artikel zu Versicherungsthemen.",
          ),
          _FaqItem(
            icon: "images/menu/vertrag.svg",
            text:
                "In der Vertragsübersicht haben Sie Zugriff auf alle Ihre Verträge.",
          ),
          _FaqItem(
            icon: "images/menu/schaden.svg",
            text:
                "Schäden können Sie direkt und unkompliziert in der App melden.",
          ),
          _FaqItem(
            icon: "images/menu/kontakt.svg",
            text:
                "Über den Kontaktbereich erreichen Sie uns jederzeit.",
          ),
        ],
      ),
    );
  }

  /// 🔹 Header redesigné (remplace layout rigide)
  /*Widget _HeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: helmsauerBlau,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "Willkommen bei myHelmsauer",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // 🔹 Logos alignés proprement
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              4,
              (i) => Image.asset(
                "images/siegel/${i + 1}.png",
                height: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  /// 🔹 Carte article (Material + elevation)
  Widget _NewsCard(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text("Cyberkriminalität")),
              body: PdfViewer.openAsset("images/cyber.pdf"),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset("images/cyber.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Cyberkriminalität – so schützen Sie Ihr Unternehmen",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Titre de section moderne
  Widget _SectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  /// 🔹 Élément FAQ redesigné (cards)
  Widget _FaqItem({required String icon, required String text}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 32,
            colorFilter:
                ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
