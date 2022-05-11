import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'context.dart';
import 'generator.dart';
import 'io.dart';
import 'l10n.dart';
import 'notice.dart';

typedef Host = String Function();
typedef HttpListener = Future<bool> Function(String uri, Headers headers);

class Http {
  static Host? _host;
  static String _sid = '';
  static const String __sid = 'sid';
  static final List<HttpListener> _listeners = [];
  static final Set<String> _downloading = {};

  static void init(Host host) {
    _host = host;
  }

  static void listen(HttpListener listener) => _listeners.add(listener);

  static Future<dynamic> service(String uri, {dynamic data, bool message = false}) async {
    Map<String, dynamic> map = await post(uri, data);
    if (message && map.containsKey('message')) {
      String message = map['message'];
      if (message != '') {
        int code = map['code'];
        if (code == 0) {
          Notice.info(message);
        } else {
          Notice.error(map['code'], message);
        }
      }
    }

    return Future.value(map.containsKey('data') ? map['data'] : null);
  }

  static Future<Map<String, dynamic>?> upload(String name, {String? file, List<int>? bytes, String? filename, String? contentType}) async {
    if (file != null && file.startsWith('data:')) {
      String contentType = file.substring(5, file.indexOf(';'));

      return await Http.post('/photon/ctrl/upload', {
        'name': name,
        'contentType': contentType,
        'fileName': contentType.replaceAll('/', '.'),
        'base64': file.substring(file.indexOf(',') + 1),
      });
    }

    MultipartFile? mf;
    MediaType? mt = contentType == null ? null : MediaType.parse(contentType);
    if (file != null) {
      mf = await MultipartFile.fromFile(file, filename: filename, contentType: mt);
    } else if (bytes != null) {
      mf = MultipartFile.fromBytes(bytes, filename: filename, contentType: mt);
    }
    if (mf == null) return Future.value(null);

    return await post('/photon/ctrl-http/upload', FormData.fromMap({name: mf}));
  }

  static Future<Map<String, dynamic>> post(String uri, dynamic data) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(_url(uri), data: data, options: _options());
      dio.close();

      if (response.statusCode != 200) {
        return Future.value({
          'code': response.statusCode,
          'message': response.statusMessage,
        });
      }

      for (HttpListener listener in _listeners) {
        if (await listener(uri, response.headers)) {
          _sid = '';
          Context.remove(__sid);
        }
      }

      return Future.value(response.data);
    } on Exception {
      return Future.value({
        'code': 500,
        'message': Context.context == null ? 'HTTP request error' : l10n(null, 'http.error'),
      });
    }
  }

  static Future<bool> download(String uri, String path) async {
    if (Context.isWeb) return Future.value(false);

    if (_downloading.contains(path)) {
      for (; true;) {
        await Future.delayed(const Duration(seconds: 1));
        if (!_downloading.contains(path)) return Future.value(true);
      }
    }

    _downloading.add(path);
    await Io.mkdirs(path.substring(0, path.lastIndexOf(Platform.pathSeparator)));
    String downloading = path + '.downloading';
    try {
      Dio dio = Dio();
      Response response = await dio.download(
        _url(uri),
        downloading,
        options: _options(),
      );
      dio.close();
      await Io.rename(downloading, path);
      _downloading.remove(path);
      return Future.value(response.statusCode == 200);
    } on Exception {
      await Io.delete(downloading);
      _downloading.remove(path);
      return Future.value(false);
    }
  }

  static Options _options() => Options(headers: {
        'photon-session-id': sid,
        'accept-language': L10n.locale,
      });

  static String get sid {
    if (_sid == '') {
      String? sid = Context.get(__sid);
      if (sid == null || sid == '') {
        _sid = Generator.string(64);
        Context.set(__sid, _sid);
      } else {
        _sid = sid;
      }
    }

    return _sid;
  }

  static String url(String? string) {
    if (string == null) return '';

    return string.contains('://') ? string : _url(string);
  }

  static String _url(String uri) {
    if (Context.isWeb) return uri;

    return _host!() + uri;
  }
}
