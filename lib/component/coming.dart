import 'package:flutter/material.dart';

import '../util/l10n.dart';
import '../util/router.dart';
import 'popage.dart';

class Coming {
  static void push() {
    PageRouter.push(const ComingSoonPage());
  }
}

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Text(l10n(null, 'comming-soon')),
      );
}

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const PopPage(
        body: ComingSoon(),
      );
}
