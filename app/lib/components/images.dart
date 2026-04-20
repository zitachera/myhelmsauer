/*import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoCollection extends StatelessWidget {
  const PhotoCollection({
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
    return SizedBox(
      height: 150,
      child: Row(
        children: cells,
      ),
    );
  }
}

class PhotoCollectionField extends StatelessWidget {
  const PhotoCollectionField({
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
                elevation: 0,
                backgroundColor: Colors.black.withAlpha(0x44),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
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
    return SizedBox(
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
                        colors: [
                          Colors.black.withAlpha(0x99),
                          Color(0x00000000)
                        ],
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
      backgroundColor: Color.fromARGB(0, 227, 224, 224),
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
                  elevation: 0,
                  backgroundColor: Colors.black.withAlpha(0x44),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
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
          builder: (context) =>
              NewImageDialog(label: label, info: info, onAdd: onAdd),
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
                        "Wählen Sie ein Foto aus Ihrer Galerie aus oder nehmen Sie ein neues Foto auf "
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
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(borderRadius + 1),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: child,
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
      borderColor: borderColor,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: SizedBox.expand(
          child: child,
        ),
      ),
    );
  }
}*/

/*import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// PHOTO COLLECTION (READ-ONLY)

class PhotoCollection extends StatelessWidget {
  const PhotoCollection({
    super.key,
    required this.images,
    required this.label,

  });

  final List<Uint8List> images;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return _ImageCard(
            image: images[index],
            caption: label,
          );
        },
      ),
    );
  }
}

/// PHOTO COLLECTION WITH ADD / DELETE

class PhotoCollectionField extends StatelessWidget {
  const PhotoCollectionField({
    super.key,
    required this.images,
    required this.max,
    required this.label,
    required this.labelAdd,
    required this.onDelete,
    required this.onAdd,
    this.infoAdd, 
   this.alignment = WrapAlignment.start,
    
  });

  final List<Uint8List> images;
  final int max;
  final String label;
  final String labelAdd;
  final Widget? infoAdd;
  final WrapAlignment alignment;
  final Function(int index) onDelete;
  final Function(Uint8List image) onAdd;

  @override
  Widget build(BuildContext context) {
    final canAdd = images.length < max;

    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: canAdd ? images.length + 1 : images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          if (index < images.length) {
            return _ImageCard(
              image: images[index],
              caption: '$label ${index + 1}',
              onDelete: () => onDelete(index),
            );
          }

          /// Bouton ADD
          return _AddPhotoCard(
            label: labelAdd,
            info: infoAdd,
            onAdd: onAdd,
          );
        },
      ),
    );
  }
}

/// IMAGE CARD (MODERNE + ANIMATION)

class _ImageCard extends StatelessWidget {
  const _ImageCard({
    required this.image,
    required this.caption,
    this.onDelete,
  });

  final Uint8List image;
  final String caption;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: image,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => _ImagePreviewDialog(
                image: image,
                onDelete: onDelete,
              ),
            );
          },
          child: SizedBox(
            width: 140,
            child: Stack(
              children: [
                /// Image
                Positioned.fill(
                  child: Image.memory(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),

                /// Gradient + caption
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black87,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Text(
                      caption,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// IMAGE PREVIEW DIALOG (FULLSCREEN MODERNE)

class _ImagePreviewDialog extends StatelessWidget {
  const _ImagePreviewDialog({
    required this.image,
    this.onDelete,
  });

  final Uint8List image;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          /// Image plein écran
          Center(
            child: Hero(
              tag: image,
              child: Image.memory(image),
            ),
          ),

          /// Boutons
          Positioned(
            top: 12,
            right: 12,
            child: Row(
              children: [
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      onDelete!.call();
                      Navigator.pop(context);
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ADD PHOTO CARD (DESIGN M3)

class _AddPhotoCard extends StatelessWidget {
  const _AddPhotoCard({
    required this.label,
    required this.onAdd,
    this.info,
  });

  final String label;
  final Function(Uint8List image) onAdd;
  final Widget? info;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (_) => _NewImageBottomSheet(
              label: label,
              info: info,
              onAdd: onAdd,
            ),
          );
        },
        child: SizedBox(
          width: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// BOTTOM SHEET – AJOUT IMAGE

class _NewImageBottomSheet extends StatelessWidget {
  const _NewImageBottomSheet({
    required this.label,
    required this.onAdd,
    this.info,
  });

  final String label;
  final Widget? info;
  final Function(Uint8List image) onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (info != null) info!,
          const SizedBox(height: 12),
          const Text(
            "Wählen Sie ein Foto aus Ihrer Galerie aus oder nehmen Sie ein neues Foto auf.",
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _AddImageAction(
                icon: Icons.photo_library,
                label: "Galerie",
                source: ImageSource.gallery,
                onAdd: onAdd,
              ),
              const SizedBox(width: 12),
              _AddImageAction(
                icon: Icons.camera_alt,
                label: "Kamera",
                source: ImageSource.camera,
                onAdd: onAdd,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ACTION PICK IMAGE

class _AddImageAction extends StatelessWidget {
  const _AddImageAction({
    required this.icon,
    required this.label,
    required this.source,
    required this.onAdd,
  });

  final IconData icon;
  final String label;
  final ImageSource source;
  final Function(Uint8List image) onAdd;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: () async {
          Navigator.pop(context);

          final picker = ImagePicker();
          final file = await picker.pickImage(
            source: source,
            imageQuality: 90,
            maxWidth: 2048,
            maxHeight: 2048,
          );

          if (file == null) return;

          final bytes = await file.readAsBytes();
          onAdd(bytes);
        },
      ),
    );
  }
}*/

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// PHOTO COLLECTION (READ-ONLY)
class PhotoCollection extends StatelessWidget {
  const PhotoCollection({
    super.key,
    required this.images,
    required this.label,
  });

  final List<Uint8List> images;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return _ImageCard(
            image: images[index],
            caption: label,
          );
        },
      ),
    );
  }
}

/// PHOTO COLLECTION WITH ADD / DELETE
class PhotoCollectionField extends StatelessWidget {
  const PhotoCollectionField({
    super.key,
    required this.images,
    required this.max,
    required this.label,
    required this.labelAdd,
    required this.onDelete,
    required this.onAdd,
    this.infoAdd,
    this.alignment = WrapAlignment.start,
  });

  final List<Uint8List> images;
  final int max;
  final String label;
  final String labelAdd;
  final Widget? infoAdd;
  final WrapAlignment alignment;
  final Function(int index) onDelete;
  final Function(Uint8List image) onAdd;

  @override
  Widget build(BuildContext context) {
    final canAdd = images.length < max;

    return SizedBox(
      height: 160,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Wrap(
          alignment: alignment,
          spacing: 10,
          runSpacing: 10,
          children: [
            ...images.asMap().entries.map((entry) {
              final index = entry.key;
              final img = entry.value;
              return _ImageCard(
                image: img,
                caption: '$label ${index + 1}',
                onDelete: () => onDelete(index),
              );
            }),
            if (canAdd)
              _AddPhotoCard(
                label: labelAdd,
                info: infoAdd,
                onAdd: onAdd,
              ),
          ],
        ),
      ),
    );
  }
}

/// IMAGE CARD
class _ImageCard extends StatelessWidget {
  const _ImageCard({
    required this.image,
    required this.caption,
    this.onDelete,
  });

  final Uint8List image;
  final String caption;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: image,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => _ImagePreviewDialog(
                image: image,
                onDelete: onDelete,
              ),
            );
          },
          child: SizedBox(
            width: 140,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.memory(image, fit: BoxFit.cover),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black87, Colors.transparent],
                      ),
                    ),
                    child: Text(
                      caption,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// IMAGE PREVIEW DIALOG
class _ImagePreviewDialog extends StatelessWidget {
  const _ImagePreviewDialog({required this.image, this.onDelete});

  final Uint8List image;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          Center(child: Hero(tag: image, child: Image.memory(image))),
          Positioned(
            top: 12,
            right: 12,
            child: Row(
              children: [
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      onDelete!.call();
                      Navigator.pop(context);
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ADD PHOTO CARD
class _AddPhotoCard extends StatelessWidget {
  const _AddPhotoCard({required this.label, required this.onAdd, this.info});

  final String label;
  final Function(Uint8List image) onAdd;
  final Widget? info;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (_) => _NewImageBottomSheet(
              label: label,
              info: info,
              onAdd: onAdd,
            ),
          );
        },
        child: SizedBox(
          width: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(color: color, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// BOTTOM SHEET – NEW IMAGE
class _NewImageBottomSheet extends StatelessWidget {
  const _NewImageBottomSheet(
      {required this.label, required this.onAdd, this.info});

  final String label;
  final Widget? info;
  final Function(Uint8List image) onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          if (info != null) info!,
          const SizedBox(height: 12),
          const Text(
            "Wählen Sie ein Foto aus Ihrer Galerie aus oder nehmen Sie ein neues Foto auf.",
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _AddImageAction(
                icon: Icons.photo_library,
                label: "Galerie",
                source: ImageSource.gallery,
                onAdd: onAdd,
              ),
              const SizedBox(width: 12),
              _AddImageAction(
                icon: Icons.camera_alt,
                label: "Kamera",
                source: ImageSource.camera,
                onAdd: onAdd,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// PICK IMAGE ACTION
class _AddImageAction extends StatelessWidget {
  const _AddImageAction(
      {required this.icon,
      required this.label,
      required this.source,
      required this.onAdd});

  final IconData icon;
  final String label;
  final ImageSource source;
  final Function(Uint8List image) onAdd;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: () async {
          Navigator.pop(context);
          final picker = ImagePicker();
          final file = await picker.pickImage(
            source: source,
            imageQuality: 90,
            maxWidth: 2048,
            maxHeight: 2048,
          );
          if (file == null) return;
          final bytes = await file.readAsBytes();
          onAdd(bytes);
        },
      ),
    );
  }
}
