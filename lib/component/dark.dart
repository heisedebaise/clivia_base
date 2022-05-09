import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifier.dart';
import '../util/context.dart';
import '../util/l10n.dart';

class Dark extends StatelessWidget {
  const Dark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SwitchListTile(
        title: Text(l10n(context, 'dark')),
        subtitle: Text(l10n(context, 'dark.explain')),
        value: Theme.of(context).brightness == Brightness.dark,
        onChanged: (bool on) async {
          await Context.set('theme', on ? 'dark' : 'light');
          Provider.of<Notifier>(context, listen: false).notify();
        },
      );
}
