import 'package:customer_portal_app/melden.dart';
import 'package:customer_portal_app/vertrag.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helmsauer Versicherungen Portal',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        secondaryHeaderColor: Colors.amber,
      ),
      home: MyHomePage(title: 'Helmsauer Versicherungen Portal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  //centerTitle: true,
                  title: Text(" Helmsauer ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        backgroundColor: Colors.blue,
                      )),
                  background: Image.asset(
                    "assets/images/tower-background.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                bottom: PreferredSize(
                    child: Container(
                      color: Colors.red,
                      height: 2.0,
                    ),
                    preferredSize: Size.fromHeight(2.0)),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              Text(
                "Meine Meldungen",
                textScaleFactor: 2,
              ),
              FlatButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VertragPage()),
                  ),
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "20.01.2020",
                        textScaleFactor: 1.3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Fall XY",
                        textScaleFactor: 1.3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Wird Gesendet",
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VertragPage()),
                  ),
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "28.01.2020",
                        textScaleFactor: 1.3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Fall XY",
                        textScaleFactor: 1.3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "In Bearbeitung",
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VertragPage()),
                  ),
                },
                child: Text("5 Abgeschlossene Meldungen"),
              ),
              Text(
                "Meine Verträge",
                textScaleFactor: 2,
              ),
              FlatButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VertragPage()),
                  ),
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Wichtiger Vertrag A",
                        textScaleFactor: 1.3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Allianz",
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VertragPage()),
                  ),
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Zusätzlicher Vertrag B",
                        textScaleFactor: 1.3,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "HUK",
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeldenPage()),
          ),
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add_to_photos),
      ),
    );
  }
}
