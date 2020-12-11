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
              child: Image.asset(
                "images/Siegel1.jpg",
                fit: BoxFit.fitWidth,
              ),
              flex: 1,
            ),
            Expanded(
              child: Image.asset(
                "images/Siegel2.jpg",
                fit: BoxFit.fitWidth,
              ),
              flex: 1,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Image.asset(
                "images/Siegel4.png",
                fit: BoxFit.fitWidth,
              ),
              flex: 1,
            ),
            Expanded(
              child: Image.asset(
                "images/Siegel3.png",
                fit: BoxFit.fitWidth,
              ),
              flex: 1,
            ),
          ],
        ),
      ],
    );
  }
}
