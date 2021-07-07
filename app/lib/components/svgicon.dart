import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final Color? color;
  final String asset;
  final double? width;
  final double? height;

  const SvgIcon(this.asset, {Key? key, this.color, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      height: height,
      width: width,
      color: color ?? Theme.of(context).iconTheme.color,
    );
  }
}
