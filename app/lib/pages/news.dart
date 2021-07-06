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
              // images/menu/rot/schaden.svg
              "images/schaden.svg", //"images/menu/weiß/aktuelles.svg",
              color: Colors.white,
            ),
            "text")
      ],
    );
  }

  Widget _faqTop(Widget icon, String text) => Container(
        decoration: new BoxDecoration(
            color: helmsauerBlau,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: FittedBox(
                child: icon,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Text(text),
            ),
          ],
        ),
      );

  Widget _faqMiddle(Widget icon, String text) => Row(
        children: [
          Expanded(
              child: Container(
            decoration: new BoxDecoration(
                color: Color.fromARGB(255, 241, 244, 247),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text("test"),
          )),
        ],
      );

  Widget _faqBottom(Widget icon, String text) => Row(
        children: [
          Expanded(
              child: Container(
            decoration: new BoxDecoration(
                color: Color.fromARGB(255, 241, 244, 247),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text("test"),
          )),
        ],
      );
}
