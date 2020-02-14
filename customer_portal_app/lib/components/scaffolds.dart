import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';

class HsSingleChildScrollScaffold extends StatelessWidget {
  HsSingleChildScrollScaffold(
      {Key key, this.title, this.body, this.actions, this.floatingActionButton})
      : super(key: key);

  final String title;
  final Widget body;
  final List<Widget> actions;

  /// A button displayed floating above [body], in the bottom right corner.
  ///
  /// Typically a [FloatingActionButton].
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        actions: actions,
        bottom: PreferredSize(
            child: Container(
              color: hemlsauerRed,
              height: 2.5,
            ),
            preferredSize: Size.fromHeight(2.5)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
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
              title: Stack(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Chub Gothic',
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 5
                        ..color = hemlsauerBlue,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Chub Gothic',
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
                color: hemlsauerRed,
                height: 2.5,
              ),
              preferredSize: Size.fromHeight(2.5),
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () => Future.delayed(Duration(seconds: 5)),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
