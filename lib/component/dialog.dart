import 'package:flutter/material.dart';

import '../util/l10n.dart';
import '../util/router.dart';

class Dialogs {
  static Future<dynamic> alert(BuildContext context, {Widget? title, Widget? content}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Alert(
        title: title,
        content: content,
      ),
    );
  }

  static Future<dynamic> confirm(BuildContext context, {Widget? title, Widget? content, Future<bool> Function()? ok}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Confirm(
        title: title,
        content: content,
        ok: ok,
      ),
    );
  }
}

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
  final Future<bool> Function()? ok;

  const Confirm({Key? key, this.title, this.content, this.ok}) : super(key: key);

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
              if (ok == null || await ok!()) {
                PageRouter.pop(true);
              }
            },
          )
        ],
      );
}
