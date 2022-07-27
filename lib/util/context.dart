import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'io.dart';

class Context {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String _path = 'context';
  static SharedPreferences? _sharedPreferences;
  static Map<String, dynamic> _map = {};
  static final Map<String, dynamic> _memory = {};
  static Orientation? _orientation;

  static get isWeb => kIsWeb;

  static get isAndroid => !kIsWeb && Platform.isAndroid;

  static get isIOS => !kIsWeb && Platform.isIOS;

  static get isWindows => !kIsWeb && Platform.isWindows;

  static get isMacOS => !kIsWeb && Platform.isMacOS;

  static get isLinux => !kIsWeb && Platform.isLinux;

  static get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static get isDesktop => !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  static Future<void> init() async {
    if (isWeb) {
      _sharedPreferences = await SharedPreferences.getInstance();

      return;
    }

    Map<String, dynamic>? map = await Io.readAsMap(_path);
    if (map != null) _map = map;
  }

  static bool has(String key, dynamic value, {bool memory = false}) {
    return get(key, memory: memory) == value;
  }

  static dynamic get(String key, {dynamic defaultValue, bool memory = false}) {
    if (memory) return _memory.containsKey(key) ? _memory[key] : defaultValue;

    if (isWeb) return _getSharedPreferences(key) ?? defaultValue;

    return _map[key] ?? defaultValue;
  }

  static dynamic _getSharedPreferences(String key) {
    String? string = _sharedPreferences?.getString(key);
    if (string == null) return null;

    Map<String, dynamic>? map = json.decode(string);
    if (map == null || !map.containsKey('value')) return null;

    return map['value'];
  }

  static Future<void> set(String key, dynamic value, {bool memory = false}) async {
    if (memory) {
      _memory[key] = value;

      return;
    }

    if (isWeb) {
      _sharedPreferences?.setString(key, json.encode({'value': value}));

      return;
    }

    _map[key] = value;
    await _write();
  }

  static Future<void> sets(Map<String, dynamic> map, {bool memory = false}) async {
    if (map.isEmpty) return;

    if (memory) {
      _memory.addAll(map);

      return;
    }

    if (isWeb) {
      map.forEach((key, value) => _sharedPreferences?.setString(key, json.encode({'value': value})));

      return;
    }

    _map.addAll(map);
    await _write();
  }

  static Future<dynamic> remove(String key, {bool memory = false}) async {
    if (memory) return Future.value(_memory.remove(key));

    if (isWeb) {
      dynamic value = _getSharedPreferences(key);
      await _sharedPreferences?.remove(key);

      return Future.value(value);
    }

    dynamic value = _map.remove(key);
    await _write();

    return Future.value(value);
  }

  static Future<void> _write() async => await Io.writeMap(_path, _map);

  static ThemeData get theme {
    String theme = get('theme', defaultValue: '');
    if (theme == '' && SchedulerBinding.instance.window.platformBrightness == Brightness.dark) {
      theme = 'dark';
    }

    return theme == 'dark' ? ThemeData.dark() : ThemeData.light();
  }

  static BuildContext? get context => navigatorKey.currentContext;

  static set orientation(Orientation orientation) {
    _orientation = orientation;
  }

  static bool get landscape => _orientation == Orientation.landscape;
}
