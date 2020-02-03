import 'package:flutter/material.dart';

class MeldenPage extends StatefulWidget {
  MeldenPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MeldenState createState() => _MeldenState();
}

class _MeldenState extends State<MeldenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schaden Melden'),
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
                    "Vertrag:",
                    textScaleFactor: 1.3,
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    "Vertrag XY",
                    textScaleFactor: 1.3,
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => {},
                child: Text(
                  "14.01.2020",
                  textScaleFactor: 1.3,
                ),
              ),
              FlatButton(
                onPressed: () => {},
                child: Text(
                  "14:02",
                  textScaleFactor: 1.3,
                ),
              ),
              Icon(Icons.location_city),
              FlatButton(
                onPressed: () => {},
                child: Text(
                  "Coronastr 12, Nürnberg",
                  textScaleFactor: 1.3,
                ),
              ),
            ],
          ),
          Text(
            "Beschreibung",
            textScaleFactor: 2,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: TextEditingController(
                text:
                    "Lorem ipsum dolor sit amet, conempor invidunt ut laboret, sed diam voluptua. At vero eos eet jusea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  "assets/images/crash 2.png",
                  width: 150,
                  height: 150,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  "assets/images/crash 4.png",
                  width: 150,
                  height: 150,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  "assets/images/crash 3.png",
                  width: 150,
                  height: 150,
                  //color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  "assets/images/crash 5.png",
                  width: 150,
                  height: 150,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
