import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifier.dart';
import 'context.dart';
import 'io.dart';

class L10n {
  static final Map<String, String> _map = {};
  static const String _language = 'language';
  static final Map<String, String> _languages = {
    'en': 'English',
    'zh': '简体中文',
  };
  static String _locale = '';
  static final Map<String, String> languages = {};

  static Future<void> load(List<String> locales, List<String> keys) async {
    _locale = await Context.get(_language, defaultValue: 'en');
    for (String locale in locales) {
      languages[locale] = _languages[locale] ?? '';
      for (String key in keys) {
        String k = '$key/$locale.json';
        if (locale == _locale) {
          _load(await Io.loadMap(k), locale);
        } else {
          Io.loadMap(k).then((map) => _load(map, locale));
        }
      }
    }
  }

  static void _load(Map<String, dynamic>? map, String prefix) {
    if (map == null || map.isEmpty) return;

    for (String key in map.keys) {
      dynamic value = map[key];
      if (key == '') {
        key = prefix;
      } else if (prefix != '') {
        key = '$prefix.$key';
      }
      if (value is Map<String, dynamic>) {
        _load(value, key);

        continue;
      }

      _map[key] = value;
    }
  }

  static String get(BuildContext? context, String key, [List<dynamic>? args]) {
    String k = '${(context ?? Context.context)?.watch<Notifier>().locale ?? _locale}.$key';
    if (!_map.containsKey(k)) return key;

    String value = _map[k] ?? key;
    if (args != null && args.isNotEmpty) {
      for (dynamic arg in args) {
        value = value.replaceFirst('{}', arg.toString());
      }
    }

    return value;
  }

  static Future<void> setLocale(BuildContext context, String locale) async {
    _locale = locale;
    await Context.set(_language, _locale);
    Provider.of<Notifier>(context, listen: false).locale = locale;
  }

  static String get locale => _locale;
}

String l10n(BuildContext? context, String key, [List<dynamic>? args]) => L10n.get(context, key, args);
