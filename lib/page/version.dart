import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../component/dividers.dart';
import '../component/popage.dart';
import '../util/l10n.dart';
import '../util/router.dart';
import '../util/upgrader.dart';

class Version extends StatelessWidget {
  const Version({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          children: [
            Expanded(child: Text(l10n(context, 'version'))),
            name(context),
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(const VersionPage());
        },
      );

  Widget name(BuildContext context) {
    String name = Upgrader.name;
    if (name.isEmpty) return Container();

    Text text = Text(
      name,
      style: Theme.of(context).textTheme.bodyText2,
    );

    return Upgrader.newer ? Badge(child: text) : text;
  }
}

class VersionPage extends StatelessWidget {
  const VersionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: l10n(null, 'version'),
        body: ListView(
          children: [
            Column(
              children: [
                Image.asset(
                  'images/logo.png',
                  width: 128,
                  fit: BoxFit.fill,
                ),
                // Text(S.of(context).title),
                Text(Upgrader.name + '.' + Upgrader.version.toString()),
              ],
            ),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(Upgrader.name + '.' + Upgrader.version.toString()),
                  ),
                  Dividers.line,
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(Upgrader.explain),
                  ),
                ],
              ),
            ),
            newer(context),
          ],
        ),
      );

  Widget newer(BuildContext context) {
    if (!Upgrader.newer) return Container();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: Upgrader.forward,
          child: Text(l10n(null, 'version.forward')),
        ),
      ),
    );
  }
}
