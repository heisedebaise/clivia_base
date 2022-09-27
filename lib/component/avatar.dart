import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../util/http.dart';
import 'cachedimage.dart';

class Avatar extends StatelessWidget {
  final String uri;
  final String nick;
  final double size;
  final bool circular;
  final Color? background;
  final Color? foreground;

  const Avatar({Key? key, this.uri = '', this.nick = '', this.size = 64, this.circular = false, this.background, this.foreground}) : super(key: key);

  @override
  Widget build(BuildContext context) => circular ? _oval() : _rect();

  Widget _oval() => Align(
        child: ClipOval(
          child: _image(),
        ),
      );

  Widget _rect() => Align(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 8),
          child: _image(),
        ),
      );

  Widget _image() {
    if (kIsWeb) {
      return Image.network(
        Http.url(uri),
        width: size,
        height: size,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => _placeholder(context),
      );
    }

    return CachedImage(
      uri: uri,
      width: size,
      height: size,
      placeholder: _placeholder,
    );
  }

  Widget _placeholder(BuildContext context) {
    Widget child;
    Color? color = foreground ?? (Theme.of(context).brightness == Brightness.light ? Colors.black45 : null);
    if (nick.isEmpty) {
      child = Icon(
        Icons.person,
        size: size,
        color: color,
      );
    } else {
      child = Center(
        child: Text(
          nick[0],
          style: TextStyle(
            color: color,
            fontSize: size * 0.5,
          ),
        ),
      );
    }

    return Container(
      color: background ?? Colors.black26,
      width: size,
      height: size,
      child: child,
    );
  }
}
