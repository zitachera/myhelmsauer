import 'package:customer_portal_app/components/const.dart';
import 'package:flutter/material.dart';

class HsSingleChildScrollScaffold extends StatelessWidget {
  HsSingleChildScrollScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.onRefresh,
  }) : super(key: key);

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;

  final Future<void> Function()? onRefresh;

  /// A button displayed floating above [body], in the bottom right corner.
  ///
  /// Typically a [FloatingActionButton].
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    Widget scrollView = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      child: body,
    );
    if (onRefresh != null) {
      scrollView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: scrollView,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        actions: actions,
        bottom: appBarBottom,
      ),
      body: scrollView,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

PreferredSize appBarBottom = const PreferredSize(
    child: const Divider(
      color: helmsauerRot,
      thickness: 2.5,
      height: 2.5,
    ),
    preferredSize: const Size.fromHeight(2.5));

class HsNestedScrollScaffold extends StatelessWidget {
  HsNestedScrollScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.bottomNavigationBar,
    this.onRefresh,
    this.actions,
  }) : super(key: key);

  final String title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    Widget scrollView = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      child: body,
    );
    if (onRefresh != null) {
      scrollView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: scrollView,
      );
    }
    return Scaffold(
      body: NestedScrollView(
        key: ValueKey(body.key),
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            actions: actions,
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Stack(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'FuturaRound',
                    ),
                  ),
                ],
              ),
              background: Image.asset(
                "images/tower-background.jpg",
                fit: BoxFit.cover,
              ),
            ),
            bottom: appBarBottom,
          ),
        ],
        body: scrollView,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  final Future<void> Function()? onRefresh;
}
