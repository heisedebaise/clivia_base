import 'package:flutter/material.dart';

import 'dividers.dart';

class Tabview extends StatefulWidget {
  final List<String> titles;
  final List<Widget> bodies;
  final int index;
  final bool divider;

  const Tabview({Key? key, required this.titles, required this.bodies, this.index = 0, this.divider = true}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabviewState();
}

class _TabviewState extends State<Tabview> {
  late int index = widget.index;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [titles()];
    if (widget.divider) children.add(Dividers.line);
    children.add(widget.bodies[index]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget titles() {
    List<Widget> children = [];
    for (int i = 0; i < widget.titles.length; i++) {
      children.add(GestureDetector(
        child: Text(
          widget.titles[i],
          style: TextStyle(color: i == index ? null : Theme.of(context).disabledColor),
        ),
        onTap: () {
          setState(() {
            index = i;
          });
        },
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children,
      ),
    );
  }
}
