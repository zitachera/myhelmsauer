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
        Text("some news"),
        Placeholder(
          fallbackHeight: 150,
        ),
        Text("some other news"),
        Placeholder(
          fallbackHeight: 150,
        ),
      ],
    );
  }
}
