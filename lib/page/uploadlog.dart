import 'package:flutter/material.dart';

import '../component/dialog.dart';
import '../util/l10n.dart';

class UploadLog extends StatelessWidget {
  const UploadLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(l10n(context, 'upload-log')),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Dialogs.confirm(
            context,
            content: Text(l10n(null, 'upload-log.memo')),
          );
        },
      );
}
