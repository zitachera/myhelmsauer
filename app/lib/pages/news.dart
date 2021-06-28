import 'package:customer_portal_app/components/const.dart';
import 'package:customer_portal_app/model/portal.dart';
import 'package:customer_portal_app/pages/login.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            "images/Flyer.png",
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
