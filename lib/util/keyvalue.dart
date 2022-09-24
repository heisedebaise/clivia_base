import 'dart:convert';

import 'http.dart';

class Keyvalue {
  static Future<String> value(String key) async {
    dynamic data = await Http.service('/keyvalue/object', data: {'key': key});

    return Future.value(data == null ? '' : (data[key] ?? ''));
  }

  static Future<Map<String, dynamic>> map(String key) async {
    String string = await value(key);
    if (string.isEmpty) return {};

    return jsonDecode(string) ?? {};
  }
}
