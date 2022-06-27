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
              child: Text(l10n(null, 'ok')),
              onPressed: () {
                PageRouter.pop(context);
              },
            ),
          ),
        ],
      );
}

class Confirm extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final Future<bool> Function() ok;

  const Confirm({Key? key, this.title, this.content, required this.ok}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(
            child: Text(l10n(null, 'cancel')),
            onPressed: () {
              PageRouter.pop(context);
            },
          ),
          ElevatedButton(
            child: Text(l10n(null, 'ok')),
            onPressed: () async {
              if (await ok()) {
                PageRouter.pop(context);
              }
            },
          )
        ],
      );
}
