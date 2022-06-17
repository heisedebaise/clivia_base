import 'package:flutter/material.dart';

import '../util/l10n.dart';
import '../util/router.dart';

class Alert extends StatelessWidget {
  final Widget? title;
  final Widget? content;

  const Alert({Key? key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: title,
        content: content,
        actions: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              child: Text(l10n(context, 'ok')),
              onPressed: () {
                PageRouter.pop(context);
              },
            ),
          ),
        ],
      );
}
