import 'package:flutter/material.dart';

class HsSingleChildScrollScaffold extends StatelessWidget {
  HsSingleChildScrollScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.onRefresh,
  });

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
      ),
      body: scrollView,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
