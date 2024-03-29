import 'package:flutter/material.dart';

import '../util/router.dart';
import 'popage.dart';

class ComingSoon extends StatelessWidget {
  final Widget? child;

  const ComingSoon({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return const Center(
        child: Text('coming soon'),
      );
    }

    return GestureDetector(
      child: child,
      behavior: HitTestBehavior.translucent,
      onTap: () {
        PageRouter.push(const ComingSoonPage());
      },
    );
  }
}

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const PopPage(
        body: ComingSoon(),
      );
}
