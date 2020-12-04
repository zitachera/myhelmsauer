import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class HsSingleChildScrollScaffold extends StatelessWidget {
  HsSingleChildScrollScaffold(
      {Key key,
      this.title,
      this.body,
      this.actions,
      this.floatingActionButton,
      this.bottomNavigationBar})
      : super(key: key);

  final String title;
  final Widget body;
  final List<Widget> actions;
  final Widget bottomNavigationBar;

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
        bottom: _appBarBottom,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

PreferredSize get _appBarBottom => PreferredSize(
    child: Container(
      color: helmsauerRed,
      height: 2.5,
    ),
    preferredSize: Size.fromHeight(2.5));

class HsNestedScrollScaffold extends StatelessWidget {
  HsNestedScrollScaffold(
      {Key key, this.title, this.body, this.bottomNavigationBar})
      : super(key: key);

  final String title;
  final Widget body;
  final Widget bottomNavigationBar;

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
                        ..color = helmsauerBlue,
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
            bottom: _appBarBottom,
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
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class HsPDFViewerScaffold extends StatelessWidget {
  final String pdfPath;
  final String titel;

  HsPDFViewerScaffold({this.pdfPath, this.titel});

  @override
  Widget build(BuildContext context) => PDFViewerScaffold(
      appBar: AppBar(
        title: Text(titel),
        bottom: _appBarBottom,
      ),
      path: pdfPath);
}
