import 'package:clivia_base/util/l10n.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../util/context.dart';
import '../util/http.dart';
import 'webview_web.dart' if (dart.library.js) 'package:webview_flutter_web/webview_flutter_web.dart';

class Webview extends StatefulWidget {
  final String url;

  const Webview({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  @override
  void initState() {
    if (Context.isAndroid) {
      WebView.platform = AndroidWebView();
    } else if (Context.isWeb) {
      WebView.platform = WebWebViewPlatform();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Context.isMobile || Context.isWeb) {
      return WebView(
        initialUrl: Http.url(widget.url),
      );
    }

    return Center(
      child: Text(l10n(null, 'not-currently-supported')),
    );
  }
}
