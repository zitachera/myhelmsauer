import 'package:flutter/material.dart';

class StretchScroll extends StatelessWidget {
  const StretchScroll({
    super.key,
    required this.children,
    this.onRefresh,
  });

  final List<Widget> children;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
      Widget scrollView = SingleChildScrollView(
        physics: onRefresh == null ? null : const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      );
      if (onRefresh != null) {
        scrollView = RefreshIndicator(
          onRefresh: onRefresh!,
          child: scrollView,
        );
      }
      return scrollView;
    });
  }
}
