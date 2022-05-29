import 'package:flutter/material.dart';

import 'util/l10n.dart';

class Notifier with ChangeNotifier {
  String _locale = L10n.locale;
  int _navigation = 0;

  set locale(String locale) {
    _locale = locale;
    notifyListeners();
  }

  String get locale => _locale;

  set navigation(int navigation) {
    _navigation = navigation;
    notifyListeners();
  }

  int get navigation => _navigation;

  void notify() {
    notifyListeners();
  }
}
