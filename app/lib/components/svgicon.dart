import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final Color? color;
  final String asset;

  const SvgIcon(this.asset, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    return SvgPicture.asset(
      asset,
      height: theme.size,
      width: theme.size,
      color: color ?? theme.color,
    );
  }
}
