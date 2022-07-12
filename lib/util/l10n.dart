import 'dart:io';

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
  static String _default = '';
  static String _locale = '';
  static final Map<String, String> languages = {'': ''};

  static Future<void> load(List<String> locales, List<String> keys) async {
    _setDefault();
    _locale = await Context.get(_language, defaultValue: _default);
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
      languages[''] = get(null, 'language.default');
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
    String k = '${_watch(context)}.$key';
    if (!_map.containsKey(k)) return key;

    String value = _map[k] ?? key;
    if (args != null && args.isNotEmpty) {
      for (dynamic arg in args) {
        value = value.replaceFirst('{}', arg.toString());
      }
    }

    return value;
  }

  static String? _watch(BuildContext? context) {
    if (context == null) return _locale;

    try {
      return context.watch<Notifier>().locale;
    } catch (e) {
      return _locale;
    }
  }

  static Future<void> setLocale(BuildContext context, String locale) async {
    _locale = locale.isEmpty ? _default : locale;
    languages[''] = get(context, 'language.default');
    await Context.set(_language, _locale);
    Provider.of<Notifier>(context, listen: false).locale = _locale;
  }

  static Future<void> changeDefaultLocal(BuildContext context) async {
    if (localeFromContext.isNotEmpty) return;

    _setDefault();
    await setLocale(context, '');
  }

  static void _setDefault() {
    _default = Platform.localeName;
    _default = _default.substring(0, _default.indexOf('_'));
  }

  static String get locale => _locale;

  static String get localeFromContext => Context.get(_language, defaultValue: '');
}

String l10n(BuildContext? context, String key, [List<dynamic>? args]) => L10n.get(context, key, args);
