import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'context.dart';
import 'http.dart';
import 'l10n.dart';

class Upgrader {
  static const int version = 1;
  static Map<String, dynamic> _version = {'version': version};

  static Future<void> latest(BuildContext context) async {
    int client = _client();
    if (client == -1) return Future.value(null);

    Map<String, dynamic>? map = await Http.service('/upgrader/latest', data: {'client': '$client'});
    if (map == null || map.isEmpty || !map.containsKey('version')) return Future.value(null);

    _version = map;
    if (newer()) _show(context);

    return Future.value(null);
  }

  static int _client() {
    if (Context.isWeb) return 5;

    if (Context.isAndroid) return 0;

    if (Context.isIOS) return 1;

    if (Context.isWindows) return 2;

    if (Context.isMacOS) return 3;

    if (Platform.isLinux) return 4;

    return -1;
  }

  static Future<void> _show(BuildContext context) async => showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: Text(l10n('upgrader.newer')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Divider(height: 1),
                ),
                Text(explain()),
              ],
            ),
            actions: _actions(context),
          ));

  static List<Widget> _actions(BuildContext context) {
    List<Widget> list = [
      TextButton(
        child: Text(l10n('upgrader.forward')),
        onPressed: forward,
      ),
    ];
    if (_get('forced', 0) == 0) {
      list.add(TextButton(
        child: Text(l10n('upgrader.cancel')),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ));
    }

    return list;
  }

  static bool newer() => _get('version', version) > version;

  static String name() => _get('name', '');

  static String explain() {
    Map<String, dynamic>? map = _get('explain', null);
    if (map == null) return '';

    String language = L10n.locale;
    if (map.containsKey(language)) return map[language];

    if (map.containsKey('en')) return map['en'];

    return '';
  }

  static Future<bool> forward() async => await launchUrlString(_get('url', ''));

  static dynamic _get(String key, dynamic defaultValue) => _version.containsKey(key) ? _version[key] : defaultValue;
}
