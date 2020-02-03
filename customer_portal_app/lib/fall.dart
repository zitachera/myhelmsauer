import 'package:flutter/material.dart';

class FallPage extends StatefulWidget {
  FallPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _FallPageState createState() => _FallPageState();
}

class _FallPageState extends State<FallPage> {

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
                  title: Text("Helmsauer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        backgroundColor: Colors.blue,
                      )),
                  background: Image.asset(
                    "assets/images/tower-background.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
    );
  }
}
