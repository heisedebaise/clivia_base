import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'context.dart';
import 'http.dart';
import 'l10n.dart';
import 'notice.dart';

class Picker {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<String?> pickImage([bool camera = false]) async {
    if (Context.isMobile) {
      XFile? xfile = await _imagePicker.pickImage(source: camera ? ImageSource.camera : ImageSource.gallery);

      return Future.value(xfile?.path);
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);
    if (result == null) return null;

    return Future.value(Context.isWeb ? _imageBase64(result.files.first) : result.paths.first);
  }

  static Future<List<String>?> pickImages() async {
    if (Context.isMobile) {
      List<XFile>? xfiles = await _imagePicker.pickMultiImage();
      if (xfiles == null || xfiles.isEmpty) return Future.value(null);

      List<String> list = [];
      for (XFile xfile in xfiles) {
        list.add(xfile.path);
      }

      return Future.value(list);
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result == null) return Future.value(null);

    List<String> list = [];
    if (Context.isWeb) {
      for (PlatformFile file in result.files) {
        list.add(_imageBase64(file));
      }
    } else {
      for (String? path in result.paths) {
        if (path != null) list.add(path);
      }
    }

    return Future.value(list);
  }

  static Future<PlatformFile?> pickFile({List<String>? suffixes}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: suffixes,
      type: suffixes == null || suffixes.isEmpty ? FileType.any : FileType.custom,
    );
    if (result == null) return Future.value(null);

    return Future.value(result.files.first);
  }

  static String _imageBase64(PlatformFile file) {
    if (file.extension == null || file.bytes == null) return '';

    String type = file.extension!.toLowerCase();
    if (type == 'jpg') type = 'jpeg';

    return 'data:image/$type;base64,${base64Encode(file.bytes!)}';
  }

  static Future<Map<String, dynamic>?> uploadImage(String name, {bool camera = false, bool loading = false}) async {
    String? file = await pickImage(camera);
    if (file == null || file.isEmpty) return Future.value(null);

    if (loading) Notice.loading(true);
    Map<String, dynamic>? map = await Http.upload(name, file: file);
    if (loading) Notice.loading(false);

    return Future.value(map);
  }

  static Future<List<Map<String, dynamic>>> uploadImages(String name, {bool loading = false}) async {
    return _uploadPicks(name, await pickImages(), loading);
  }

  static Future<List<Map<String, dynamic>>> _uploadPicks(String name, List<String>? files, [bool loading = false]) async {
    if (files == null || files.isEmpty) return Future.value([]);

    if (loading) Notice.loading(true);
    List<Map<String, dynamic>> list = [];
    for (String file in files) {
      Map<String, dynamic>? map = await Http.upload(name, file: file);
      if (map != null && map.containsKey('path')) list.add(map);
    }
    if (loading) Notice.loading(false);

    return Future.value(list);
  }

  static Future<Map<String, dynamic>?> uploadFile(String name, {bool loading = false, List<String>? suffixes}) async {
    PlatformFile? file = await pickFile(suffixes: suffixes);
    if (file == null) return Future.value(null);

    if (loading) Notice.loading(true);
    Map<String, dynamic>? map = await Http.upload(name, filename: file.name, bytes: file.bytes);
    if (loading) Notice.loading(false);

    return map;
  }

  static Future<DateTime?> pickDateTime(BuildContext context, [DateTime? current]) async => DatePicker.showDateTimePicker(
        context,
        locale: _locale(),
        currentTime: current,
      );

  static LocaleType _locale() {
    if (L10n.locale == 'zh') return LocaleType.zh;

    return LocaleType.en;
  }
}
