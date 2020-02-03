import 'package:flutter/material.dart';

class VertragPage extends StatefulWidget {
  VertragPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _VertragPageState createState() => _VertragPageState();
}

class _VertragPageState extends State<VertragPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vertrag A'),
        bottom: PreferredSize(
            child: Container(
              color: Colors.red,
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(2.0)),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () => {},
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Versicherer:",
                    textScaleFactor: 1.3,
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    "Allianz",
                    textScaleFactor: 1.3,
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () => {},
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Vertragsbeginn:",
                    textScaleFactor: 1.3,
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    "03.11.2009",
                    textScaleFactor: 1.3,
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
              textScaleFactor: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
