import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'context.dart';
import 'http.dart';

class Picker {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<String?> pickImage([bool camera = false]) async {
    if (Context.isMobile) {
      XFile? xfile = await _imagePicker.pickImage(source: camera ? ImageSource.camera : ImageSource.gallery);

      return Future.value(xfile?.path);
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
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
    if (result == null || result.paths.isEmpty) return Future.value(null);

    List<String> list = [];
    for (String? path in result.paths) {
      if (path != null) list.add(path);
    }

    return Future.value(list);
  }

  static Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    return Future.value(result?.paths.first);
  }

  static String _imageBase64(PlatformFile file) {
    if (file.extension == null || file.bytes == null) return '';

    String type = file.extension!.toLowerCase();
    if (type == 'jpg') type = 'jpeg';

    return 'data:image/$type;base64,${base64Encode(file.bytes!)}';
  }

  static Future<String?> uploadImage(String name, [bool camera = false]) async {
    return _uploadPick(name, await pickImage(camera));
  }

  static Future<String?> uploadFile(String name) async {
    return _uploadPick(name, await pickFile());
  }

  static Future<String?> _uploadPick(String name, String? file) async {
    if (file == null || file.isEmpty) return Future.value(null);

    Map<String, dynamic>? map = await Http.upload(name, file: file);

    return Future.value(map == null || !map.containsKey('path') ? null : map['path']);
  }
}
