import 'package:flutter_easyloading/flutter_easyloading.dart';

class Notice {
  static void success(String message) => EasyLoading.showSuccess(message);

  static void info(String message) => EasyLoading.showInfo(message);

  static void error(int code, String message) => EasyLoading.showError(code > 0 ? '[$code] $message' : message);

  static void loading(bool show, {String? message}) {
    if (show) {
      EasyLoading.show(
        status: message,
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
    } else {
      EasyLoading.dismiss();
    }
  }
}
