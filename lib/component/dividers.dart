import 'package:flutter/material.dart';

class Dividers {
  static Widget line = _line(1);
  static Widget line3 = _line(3);
  static Widget line5 = _line(5);

  static Widget _line(double height) => Divider(height: height, thickness: height);
}
