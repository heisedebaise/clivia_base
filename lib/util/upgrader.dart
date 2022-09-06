import 'package:clivia_base/component/dividers.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'context.dart';
import 'http.dart';
import 'l10n.dart';

class Upgrader {
  static int _number = 0;
  static String _name = '';
  static Map<String, dynamic> _version = {'version': _number};

  static Future<void> latest(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _number = int.tryParse(packageInfo.buildNumber) ?? 0;
    _name = packageInfo.version;

    String client = _client();
    if (client.isEmpty) return Future.value(null);

    Map<String, dynamic>? map = await Http.service('/upgrader/latest', data: {'client': client});
    if (map == null || map.isEmpty || !map.containsKey('version')) return Future.value(null);

    _version = map;
    if (newer) _show(context);

    return Future.value(null);
  }

  static String _client() {
    if (Context.isAndroid) return 'android';

    if (Context.isIOS) return 'ios';

    if (Context.isWindows) return 'windows';

    if (Context.isMacOS) return 'macos';

    if (Context.isLinux) return 'linux';

    if (Context.isWeb) return 'web';

    return '';
  }

  static Future<void> _show(BuildContext context) async => showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(l10n(null, 'upgrader.newer')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Dividers.line,
              ),
              Text(explain),
            ],
          ),
          actions: _actions(context),
        ),
      );

  static List<Widget> _actions(BuildContext context) {
    List<Widget> list = [
      TextButton(
        child: Text(l10n(null, 'upgrader.forward')),
        onPressed: forward,
      ),
    ];
    if (_get('forced', 0) == 0) {
      list.add(TextButton(
        child: Text(l10n(null, 'upgrader.cancel')),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ));
    }

    return list;
  }

  static bool get newer => _get('version', _number) > _number;

  static String get name => _get('name', _name);

  static int get version => _number;

  static String get explain {
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
