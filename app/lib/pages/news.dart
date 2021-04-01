import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
