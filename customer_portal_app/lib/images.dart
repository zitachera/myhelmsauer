import 'package:customer_portal_app/model/types.dart';
import 'package:customer_portal_app/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

// experimental file um ein image collector widget zu bauen


// widget... (string[] pictures, Image add, int max, string caption, string captionAdd)

class XXImageBoxPage extends StatefulWidget {
  XXImageBoxPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _XXImageBoxPageState createState() => _XXImageBoxPageState();
}

class _XXImageBoxPageState extends State<XXImageBoxPage> {
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
      headerSliverBuilder: _appBar,
      body: Column(
        children: <Widget>[
        ],
      ),
    ));
  }

  List<Widget> _appBar(context, innerBoxIsScrolled) => <Widget>[
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
              "images/tower-background.jpg",
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
}

class ImageCollecter extends StatefulWidget {
  ImageCollecter({Key key}) : super(key: key);


  @override
  _ImageCollecterState createState() => _ImageCollecterState();
}

class _ImageCollecterState extends State<ImageCollecter> {

  @override
  Widget build(BuildContext context) {
    return GridView(gridDelegate: null);
  }


}
