import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

// experimental file um ein image collector widget zu bauen

// widget... (string[] pictures, Image add, int max, string caption, string captionAdd)

class FotoAdderRow extends StatelessWidget {
  FotoAdderRow({Key key, this.images, this.max, this.imageAdder})
      : super(key: key);

  final List<String> images;
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
    for (var b64 in images) {
      cells.add(Expanded(child: _imageView(b64)));
    }
    if (images.length < max) {
      cells.add(Expanded(child: imageAdder));
    }
    return cells;
  }

  Widget _imageView(String b64) {
    //return _imageFromBase64String(b64);
    return Image.asset(
      "images/tower-background.jpg",
      fit: BoxFit.cover,
      height: 150,
    );
  }
}

Image _imageFromBase64String(String base64String) {
  return Image.memory(
    base64Decode(base64String),
    width: 150,
    height: 150,
  );
}

Uint8List _dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String _base64String(Uint8List data) {
  return base64Encode(data);
}
