import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoCollection extends StatelessWidget {
  PhotoCollection({
    super.key,
    required this.images,
    required this.label,
  });

  final List<Uint8List> images;
  final String label;

  @override
  Widget build(BuildContext context) {
    var cells = <Widget>[];
    for (var i = 0; i < images.length; i++) {
      var image = images[i];
      cells.add(
        _ImageBox(
          image: image,
          caption: label,
        ),
      );
    }
    return Container(
      height: 150,
      child: Row(
        children: cells,
      ),
    );
  }
}

class PhotoCollectionField extends StatelessWidget {
  PhotoCollectionField({
    super.key,
    required this.images,
    required this.max,
    required this.label,
    required this.labelAdd,
    required this.onDelete,
    required this.onAdd,
    this.infoAdd,
  });

  final List<Uint8List> images;
  final int max;
  final String label;
  final String labelAdd;
  final Widget? infoAdd;

  final Function(int i) onDelete;
  final Function(Uint8List image) onAdd;

  @override
  Widget build(BuildContext context) {
    var cells = <Widget>[];
    for (var i = 0; i < images.length; i++) {
      var image = images[i];
      cells.add(
        _ImageBox(
          image: image,
          caption: "$label ${i + 1}",
          actions: <Widget>[
            Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () {
                  onDelete(i);
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                elevation: 0,
                backgroundColor: Colors.black.withAlpha(0x44),
              ),
            ),
          ],
        ),
      );
    }
    if (images.length < max) {
      cells.add(_AddButton(
        onAdd: onAdd,
        label: labelAdd,
        info: infoAdd,
      ));
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
    required this.image,
    required this.caption,
    this.actions = const <Widget>[],
  });

  final Uint8List image;
  final String caption;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return _ButtonBox(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => _ImageDialog(image: image, actions: actions),
        );
      },
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Image.memory(
              image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox.expand(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withAlpha(0x99), Color(0)],
                      ),
                    ),
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5,
                        left: 5,
                        right: 5,
                        top: 20,
                      ),
                      child: Text(
                        caption,
                        textAlign: TextAlign.center,
                        textScaler: TextScaler.linear(1.1),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageDialog extends StatelessWidget {
  const _ImageDialog({
    required this.image,
    required this.actions,
  });

  final Uint8List image;
  final List<Widget> actions;

  static const double actionSize = 56;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(actionSize / 2),
            child: Image.memory(
              image,
            ),
          ),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: actionSize,
                  height: actionSize,
                ),
                ...actions,
                FloatingActionButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
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
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    required this.onAdd,
    required this.label,
    required this.info,
  });

  final Function(Uint8List image) onAdd;
  final String label;
  final Widget? info;

  @override
  Widget build(BuildContext context) {
    var accentColor = Theme.of(context).colorScheme.secondary;
    return _ButtonBox(
      borderColor: accentColor,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => NewImageDialog(label: label, info: info, onAdd: onAdd),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.add_a_photo,
              color: accentColor,
            ),
          ),
          Text(
            label,
            textScaler: TextScaler.linear(1.1),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(color: accentColor),
          ),
        ],
      ),
    );
  }
}

class NewImageDialog extends StatelessWidget {
  const NewImageDialog({
    super.key,
    required this.label,
    this.info,
    required this.onAdd,
  });

  final String label;
  final Widget? info;
  final Function(Uint8List image) onAdd;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // TODO wrap Column in singlechildscroll?
          children: <Widget>[
            Text(
              label,
              textScaler: TextScaler.linear(1.6),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (info != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: info,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                        "Wählen Sie ein Foto aus Ihrer Galerie aus oder nehmen Sie ein neues Foto auf " +
                            "und bestätigen dieses, um es dem Bericht hinzuzufügen."),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                _AddImageAction(
                  onAdd: onAdd,
                  source: ImageSource.gallery,
                  icon: const Icon(Icons.photo_library),
                  caption: "Foto aus Galerie auswählen",
                ),
                _AddImageAction(
                  onAdd: onAdd,
                  source: ImageSource.camera,
                  icon: const Icon(Icons.camera),
                  caption: "Foto mit Kamera aufnehmen",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddImageAction extends StatelessWidget {
  const _AddImageAction({
    required this.caption,
    required this.icon,
    required this.onAdd,
    required this.source,
  });

  final String caption;
  final Icon icon;
  final Function(Uint8List image) onAdd;
  final ImageSource source;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: () async {
          Navigator.of(context).pop();

          var image = await ImagePicker().pickImage(
            source: source,
            imageQuality: 90,
            maxHeight: 2048,
            maxWidth: 2048,
          );
          if (image == null) return; // canceld

          var bytes = await image.readAsBytes();

          onAdd(bytes);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              icon,
              Text(
                caption,
                textAlign: TextAlign.center,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({
    required this.child,
    this.borderColor = const Color(0x55000000),
  });

  final Widget child;
  final Color borderColor;
  static const double borderRadius = 12.0;

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
            borderRadius: BorderRadius.circular(borderRadius + 1),
            border: Border.all(
              color: borderColor,
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
    required this.onPressed,
    required this.child,
    this.borderColor = const Color(0x55000000),
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return _Box(
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: SizedBox.expand(
          child: child,
        ),
      ),
      borderColor: borderColor,
    );
  }
}
