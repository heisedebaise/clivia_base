import 'dart:io';

import 'package:clivia_base/util/context.dart';
import 'package:flutter/material.dart';

import '../util/http.dart';
import '../util/io.dart';

class CachedImage extends StatefulWidget {
  const CachedImage({Key? key, required this.uri, this.width, this.height, this.placeholder}) : super(key: key);

  final String uri;
  final double? width;
  final double? height;
  final Widget Function(BuildContext context)? placeholder;

  @override
  State<StatefulWidget> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  String path = '';
  bool exists = false;

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CachedImage oldWidget) {
    load();
    super.didUpdateWidget(oldWidget);
  }

  void load() {
    if (Context.isWeb) return;

    if (widget.uri == '') {
      if (mounted) {
        setState(() {
          exists = false;
        });
      }

      return;
    }

    path = Io.absolute(widget.uri.substring(1));
    exists = Io.existsSync(path);
    if (exists) return;

    Http.download(widget.uri, path).then((value) {
      if (mounted) {
        setState(() {
          exists = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => Context.isWeb ? web() : (exists ? image() : empty());

  Widget web() => Image.network(
        Http.url(widget.uri),
        width: widget.width,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) => empty(),
      );

  Widget image() => Image.file(
        File(path),
        width: widget.width,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) => empty(),
      );

  Widget empty() => widget.placeholder == null ? SizedBox(width: widget.width, height: widget.height) : widget.placeholder!(context);
}
