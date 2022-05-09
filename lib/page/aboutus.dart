import 'package:flutter/material.dart';

import '../component/popage.dart';
import '../component/webview.dart';
import '../util/l10n.dart';
import '../util/router.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(l10n(context, 'about-us')),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(const AboutUsPage());
        },
      );
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: l10n(context, 'about-us'),
        body: const Webview(
          url: 'https://github.com/heisedebaise/clivia-app',
        ),
      );
}
