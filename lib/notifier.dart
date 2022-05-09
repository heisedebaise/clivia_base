import 'package:flutter/material.dart';

import 'util/l10n.dart';

class Notifier with ChangeNotifier {
  String _locale = L10n.locale;

  set locale(String locale) {
    _locale = locale;
    notifyListeners();
  }

  String get locale => _locale;

  void notify() {
    notifyListeners();
  }
}
