import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class IOSNews extends StatelessWidget {
  const IOSNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              padding: EdgeInsets.zero,
              color: const Color.fromARGB(255, 241, 244, 247),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: const Text("Cyberkriminalität"),
                    ),
                    backgroundColor: Colors.grey,
                    body: PdfViewer.openAsset("images/cyber.pdf"),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "images/cyber.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Cyberkriminalität – so schützen Sie Ihr Unternehmen!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: helmsauerBlau,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
              decoration: const BoxDecoration(
                color: helmsauerBlau,
                borderRadius: BorderRadius.zero,
              ),
              child: Text(
                "FAQ & Informationen",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _modernInfo(
            "images/menu/smartphone.svg",
            "Newsbereich mit wechselnden Artikeln zu Versicherungsthemen.",
          ),
          _modernInfo(
            "images/menu/vertrag.svg",
            "Zugriff auf alle bestehenden Versicherungsverträge.",
          ),
          _modernInfo(
            "images/menu/schaden.svg",
            "Schnelle digitale Schadenmeldung für ausgewählte Sparten.",
          ),
          _modernInfo(
            "images/menu/kontakt.svg",
            "Direkter Kontakt zu Ihrem Ansprechpartner.",
          ),
          _modernInfo(
            "images/menu/idee.svg",
            "Weitere Funktionen folgen in Kürze.",
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _modernInfo(String iconPath, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: helmsauerBlau,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  iconPath,
                  height: 22,
                  colorFilter:
                      const ColorFilter.mode(helmsauerBlau, BlendMode.srcIn),
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: dunklesBlau,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
