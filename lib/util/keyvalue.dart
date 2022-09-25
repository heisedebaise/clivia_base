import 'http.dart';

class Keyvalue {
  static Future<String> value(String key) async {
    Map<String, dynamic> m = await map(key);

    return Future.value(m[key] ?? '');
  }

  static Future<Map<String, dynamic>> map(String key) async {
    Map<String, dynamic>? data = await Http.service('/keyvalue/object', data: {'key': key});

    return Future.value(data ?? {});
  }
}
