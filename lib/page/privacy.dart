import 'dart:convert';

import 'package:flutter/material.dart';

import '../component/pdfview.dart';
import '../component/popage.dart';
import '../util/context.dart';
import '../util/http.dart';
import '../util/io.dart';
import '../util/keyvalue.dart';
import '../util/l10n.dart';
import '../util/router.dart';

class PrivacyAgreement extends StatelessWidget {
  const PrivacyAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(l10n(context, 'privacy-agreement')),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(const PrivacyAgreementPage());
        },
      );
}

class PrivacyAgreementPage extends StatefulWidget {
  const PrivacyAgreementPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PrivacyAgreementPageState();
}

class _PrivacyAgreementPageState extends State<PrivacyAgreementPage> {
  String path = '';

  @override
  void initState() {
    super.initState();
    if (Context.isLinux) return;

    Keyvalue.value('setting.agreement.privacy').then((value) async {
      if (value == '') return;

      dynamic array = json.decode(value);
      if (array == null || array.length == 0) return;

      String uri = array[0]['uri'] ?? '';
      if (uri == '') return;

      String path = Io.absolute(uri.substring(1));
      await Http.download(uri, path);
      setState(() {
        this.path = path;
      });
    });
  }

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: l10n(null, 'privacy-agreement'),
        body: Pdfview(path: path),
      );
}
