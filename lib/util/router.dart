import 'package:flutter/material.dart';

import 'context.dart';

class PageRouter {
  static Future<T?> push<T>(Widget widget) => Navigator.of(Context.context!).push(
        MaterialPageRoute(builder: (context) => widget),
      );

  static void pop() => Navigator.of(Context.context!).pop();
}
