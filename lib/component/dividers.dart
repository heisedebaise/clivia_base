import 'package:flutter/material.dart';

class Dividers {
  static Widget line = _line(1);
  static Widget line3 = _line(3);
  static Widget line5 = _line(5);

  static Widget text(String text, {double thickness = 1, double space = 8}) => Row(
        children: [
          Expanded(child: _line(thickness)),
          space > 0 ? Padding(padding: EdgeInsets.symmetric(horizontal: space), child: Text(text)) : Text(text),
          Expanded(child: _line(thickness)),
        ],
      );

  static Widget _line(double height) => Divider(height: height, thickness: height);
}
