import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import 'context.dart';

class Io {
  static String? _dir;

  static Future<void> init() async {
    if (Context.isWeb) return;

    _dir = Context.isMobile ? (await getApplicationDocumentsDirectory()).path : Directory.current.path;
    if (!_dir!.endsWith(Platform.pathSeparator)) _dir = _dir! + Platform.pathSeparator;
    _dir = _dir!.replaceAll(Platform.pathSeparator + 'app_flutter' + Platform.pathSeparator, Platform.pathSeparator);
    _dir = _dir! + 'dataset' + Platform.pathSeparator;
    await mkdirs(_dir!);
  }

  static Future<bool> exists(String path) async {
    if (Context.isWeb) return Future.value(false);

    return File(absolute(path)).exists();
  }

  static bool existsSync(String path) {
    if (Context.isWeb) return false;

    return File(absolute(path)).existsSync();
  }

  static Future<void> mkdirs(String path) async {
    if (Context.isWeb) return;

    await Directory(absolute(path)).create(recursive: true);
  }

  static void mkdirsSync(String path) {
    if (Context.isWeb) return;

    Directory(absolute(path)).createSync(recursive: true);
  }

  static Future<Uint8List?> read(String path) async {
    if (Context.isWeb) return Future.value(null);

    File file = File(absolute(path));

    return await file.exists() ? file.readAsBytes() : Future.value(null);
  }

  static Uint8List? readSync(String path) {
    if (Context.isWeb) return null;

    File file = File(absolute(path));

    return file.existsSync() ? file.readAsBytesSync() : null;
  }

  static Future<String?> readAsString(String path) async {
    if (Context.isWeb) return Future.value(null);

    File file = File(absolute(path));

    return await file.exists() ? file.readAsString() : Future.value(null);
  }

  static String? readAsStringSync(String path) {
    if (Context.isWeb) return null;

    File file = File(absolute(path));

    return file.existsSync() ? file.readAsStringSync() : null;
  }

  static Future<Map<String, dynamic>?> readAsMap(String path) async {
    String? string = await readAsString(path);
    if (string == null || string.isEmpty) return Future.value(null);

    return Future.value(json.decode(string));
  }

  static Map<String, dynamic>? readAsMapSync(String path) {
    String? string = readAsStringSync(path);
    if (string == null || string.isEmpty) return null;

    return json.decode(string);
  }

  static Future<void> write(String path, Uint8List bytes) async {
    if (Context.isWeb) return;

    await File(absolute(path)).writeAsBytes(bytes);
  }

  static void writeSync(String path, Uint8List bytes) {
    if (Context.isWeb) return;

    File(absolute(path)).writeAsBytesSync(bytes);
  }

  static Future<void> writeString(String path, String string) async {
    if (Context.isWeb) return;

    await File(absolute(path)).writeAsString(string);
  }

  static void writeStringSync(String path, String string) {
    if (Context.isWeb) return;

    File(absolute(path)).writeAsStringSync(string);
  }

  static Future<void> writeMap(String path, Map<String, dynamic> map) async {
    if (Context.isWeb) return;

    await File(absolute(path)).writeAsString(json.encode(map));
  }

  static void writeMapSync(String path, Map<String, dynamic> map) {
    if (Context.isWeb) return;

    File(absolute(path)).writeAsStringSync(json.encode(map));
  }

  static Future<void> rename(String source, String target) async {
    if (Context.isWeb) return;

    await File(absolute(source)).rename(absolute(target));
  }

  static void renameSync(String source, String target) {
    if (Context.isWeb) return;

    File(absolute(source)).renameSync(absolute(target));
  }

  static Future<void> delete(String path) async {
    if (Context.isWeb) return;

    await File(absolute(path)).delete(recursive: true);
  }

  static void deleteSync(String path) async {
    if (Context.isWeb) return;

    File(absolute(path)).deleteSync(recursive: true);
  }

  static String absolute(String path) {
    if (Context.isWeb) return path;

    if (path == '') return _dir!;

    if (Platform.isWindows) {
      if (path.contains(':\\')) {
        return path;
      }
    } else if (path[0] == Platform.pathSeparator) {
      return path;
    }

    return _dir! + path.replaceAll('/', Platform.pathSeparator);
  }
}
