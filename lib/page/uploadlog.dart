import 'package:flutter/material.dart';

import '../util/l10n.dart';

class UploadLog extends StatelessWidget {
  const UploadLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(l10n(context, 'upload-log')),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () async {
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AlertDialog(
              content: Text(l10n(context, 'upload-log.memo')),
              actions: <Widget>[
                TextButton(
                  child: Text(l10n(context, 'ok')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(l10n(context, 'cancel')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
}
