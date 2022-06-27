import 'dart:convert';
import 'dart:typed_data';

import 'package:clivia_base/component/dividers.dart';
import 'package:clivia_base/util/notice.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../util/context.dart';
import '../util/http.dart';
import '../util/l10n.dart';
import '../util/picker.dart';
import 'image.dart';
import 'piclocal.dart' if (dart.library.js) 'piclocal_web.dart';

class PicturePage extends StatefulWidget {
  final String title;
  final String upload;
  final String? uri;
  final String? local;
  final double? ratio;
  final double scale;
  final void Function(String uri)? ok;

  const PicturePage({Key? key, required this.title, required this.upload, this.uri, this.local, this.ratio, this.scale = 8, this.ok}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  final GlobalKey<ExtendedImageEditorState> editor = GlobalKey<ExtendedImageEditorState>();
  String? local;

  @override
  void initState() {
    local = widget.local;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: pick,
              icon: const Icon(Icons.add_photo_alternate_outlined),
            ),
            IconButton(
              onPressed: () async {
                Notice.loading(true);
                List<int>? data = await cropImage(editor.currentState!, rawImageData());
                if (data == null) {
                  Notice.loading(false);
                  Notice.error(0, l10n(null, 'picture.crop.fail'));

                  return;
                }

                Map<String, dynamic>? map = await Http.upload(widget.upload, bytes: data, filename: 'image.jpg', contentType: 'image/jpeg');
                if (map == null || !map.containsKey('path')) {
                  Notice.loading(false);
                  Notice.error(0, l10n(null, 'picture.upload.fail'));

                  return;
                }

                if (widget.ok != null) widget.ok!(map['path']);
                Notice.loading(false);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: body(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            toolItem(Icons.crop, l10n(null, 'picture.crop')),
            toolItem(Icons.flip, l10n(null, 'picture.flip')),
            toolItem(Icons.rotate_left, l10n(null, 'picture.rotate.left')),
            toolItem(Icons.rotate_right, l10n(null, 'picture.rotate.right')),
            toolItem(Icons.restore, l10n(null, 'picture.reset')),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          onTap: (int index) {
            switch (index) {
              case 1:
                editor.currentState?.flip();
                break;
              case 2:
                editor.currentState?.rotate(right: false);
                break;
              case 3:
                editor.currentState?.rotate();
                break;
              case 4:
                editor.currentState?.reset();
                break;
            }
          },
        ),
      );

  Widget body() {
    if (local != null) {
      return Piclocal(
        local: local!,
        extendedImageEditorKey: editor,
        initEditorConfigHandler: config,
      );
    }

    if (widget.uri != null && widget.uri != '') {
      return ExtendedImage.network(
        Http.url(widget.uri!),
        cache: true,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: editor,
        cacheRawData: true,
        initEditorConfigHandler: config,
      );
    }

    return Center(
      child: GestureDetector(
        child: Icon(
          Icons.add_photo_alternate_outlined,
          size: 64,
          color: Theme.of(context).brightness == Brightness.light ? Colors.black45 : null,
        ),
        onTap: pick,
      ),
    );
  }

  EditorConfig config(ExtendedImageState? state) => EditorConfig(
        maxScale: widget.scale,
        cropRectPadding: const EdgeInsets.all(16),
        cropAspectRatio: widget.ratio,
      );

  void pick() {
    if (!Context.isMobile) {
      pickFile(false);

      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          pickerItem(
            Icons.photo_camera,
            l10n(null, 'picture.camera'),
            true,
          ),
          Dividers.line,
          pickerItem(
            Icons.photo_album,
            l10n(null, 'picture.album'),
            false,
          )
        ],
      ),
    );
  }

  Widget pickerItem(IconData icon, String title, [bool camera = false]) => ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          pickFile(camera);
        },
      );

  Future<void> pickFile(bool camera) async {
    String? file = await Picker.pickImage(camera);
    if (file == null) return;

    setState(() {
      local = file;
      if (editor.currentState != null) editor.currentState!.reset();
    });
    if (Context.isMobile) Navigator.pop(context);
  }

  BottomNavigationBarItem toolItem(IconData icon, String label) => BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
      );

  Uint8List rawImageData() {
    if (local != null && local!.startsWith('data:image/')) {
      int indexOf = local!.indexOf(',');
      if (indexOf > -1) {
        return base64Decode(local!.substring(indexOf + 1));
      }
    }

    return editor.currentState!.rawImageData;
  }
}
