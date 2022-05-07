import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../util/context.dart';
import '../util/http.dart';

class Webview extends StatefulWidget {
  final String url;

  const Webview({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  @override
  void initState() {
    if (Context.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WebView(
        initialUrl: Http.url(widget.url),
      );
}
