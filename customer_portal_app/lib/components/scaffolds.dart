import 'package:flutter/material.dart';

class HsSingleChildScrollScaffold extends StatelessWidget {
  HsSingleChildScrollScaffold({Key key, this.title, this.body, this.actions})
      : super(key: key);

  final String title;
  final Widget body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          // style: TextStyle(
          //   fontFamily: 'Chub Gothic',
          //   fontSize: 26,
          // ),
        ),
        actions: actions,
        bottom: PreferredSize(
            child: Container(
              color: Colors.red,
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(2.0)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: body,
        ),
      ),
    );
  }
}

class HsNestedScrollScaffold extends StatelessWidget {
  HsNestedScrollScaffold({Key key, this.title, this.body}) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              //centerTitle: true,
              // TODO container for background
              title:
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 10),
                  //     child:
                  Stack(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      //color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Chub Gothic',
                      //backgroundColor: Colors.blue,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.blue,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Chub Gothic',
                      //backgroundColor: Colors.blue,
                    ),
                  ),
                ],
                // )
              ),
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
              preferredSize: Size.fromHeight(2.0),
            ),
          ),
        ],
        body: Padding(
          padding: EdgeInsets.all(10),
          child: body,
        ),
      ),
    );
  }
}
