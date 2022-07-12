import 'package:flutter/material.dart';

import '../util/l10n.dart';
import '../util/router.dart';

class Dialogs {
  static Future<dynamic> alert(BuildContext context, {Widget? title, Widget? content}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => _dialog(title, content, [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            child: Text(l10n(null, 'ok')),
            onPressed: () {
              PageRouter.pop(context);
            },
          ),
        ),
      ]),
    );
  }

  static Future<dynamic> confirm(BuildContext context, {Widget? title, Widget? content, Future<bool> Function()? ok}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => _dialog(title, content, [
        TextButton(
          child: Text(l10n(null, 'cancel')),
          onPressed: () {
            PageRouter.pop(context);
          },
        ),
        ElevatedButton(
          child: Text(l10n(null, 'ok')),
          onPressed: () async {
            if (ok == null || await ok()) {
              PageRouter.pop(true);
            }
          },
        )
      ]),
    );
  }

  static Widget _dialog(Widget? title, Widget? content, List<Widget> actions) => AlertDialog(
        title: title,
        content: content,
        actions: actions,
      );
}
