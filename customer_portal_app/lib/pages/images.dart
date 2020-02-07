import 'package:flutter/material.dart';
import 'dart:typed_data';


class PhotoCollectionRow extends StatelessWidget {
  PhotoCollectionRow({Key key, this.images, this.max, this.imageAdder})
      : super(key: key);

  final List<Uint8List> images;
  final int max;
  final Widget imageAdder;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _cells,
    );
  }

  List<Widget> get _cells {
    var cells = <Widget>[];
    for (var image in images) {
      cells.add(
        _Box(
          child: Image.memory(
            image,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    if (images.length < max) {
      cells.add(_Box(child: imageAdder));
    }
    return cells;
  }
}

class _Box extends StatelessWidget {
  const _Box({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;
  static const borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          child: ClipRRect(
            child: child,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Color(0x55000000), // oder helmsauer accent red?
              //color: Colors.red,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
