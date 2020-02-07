import 'package:flutter/material.dart';
import 'dart:typed_data';

class PhotoCollectionRow extends StatelessWidget {
  PhotoCollectionRow(
      {Key key,
      this.images,
      this.max,
      this.label,
      this.labelAdd,
      this.onDelete,
      this.onAdd})
      : super(key: key);

  final List<Uint8List> images;
  final int max;
  final String label;
  final String labelAdd;

  final Function(int i) onDelete;
  final Function(Uint8List image) onAdd;

  @override
  Widget build(BuildContext context) {
    var cells = <Widget>[];
    for (var i = 0; i < images.length; i++) {
      var image = images[i];
      cells.add(
        _ImageBox(onDelete: onDelete, index: i, image: image),
      );
    }
    if (images.length < max) {
      cells.add(_AddButton(onAdd: onAdd, label: labelAdd));
    }
    return Container(
      height: 150,
      child: Row(
        children: cells,
      ),
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({
    Key key,
    @required this.onDelete,
    @required this.index,
    @required this.image,
  }) : super(key: key);

  final Function(int index) onDelete;
  final int index;
  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return _ButtonBox(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.memory(
                  image,
                ),
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () => onDelete(index),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        elevation: 0,
                        backgroundColor: Colors.black.withAlpha(0x44),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Image.memory(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    Key key,
    @required this.onAdd,
    @required this.label,
  }) : super(key: key);

  final Function(Uint8List image) onAdd;
  final String label;

  @override
  Widget build(BuildContext context) {
    return _ButtonBox(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => Stack(
            children: <Widget>[
              // camera
              // gallery
              // info
              FlatButton(
                onPressed: () => onAdd(null), // TODO use actual image
                child: Icon(Icons.delete),
              )
            ],
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.add_a_photo,
              //color: Colors.white,
            ),
          ),
          Text(
            label,
            textScaleFactor: 1.3,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
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
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          child: ClipRRect(
            child: child,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
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

class _ButtonBox extends StatelessWidget {
  const _ButtonBox({
    Key key,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _Box(
      child: SizedBox.expand(
        child: GestureDetector(
          onTap: onPressed,
          child: child,
        ),
      ),
    );
  }
}
