import 'package:flutter/material.dart';

import 'dividers.dart';

class Tabview extends StatefulWidget {
  final List<String> titles;
  final List<Widget> bodies;
  final int index;
  final bool divider;
  final bool scrollable;

  const Tabview({Key? key, required this.titles, required this.bodies, this.index = 0, this.divider = true, this.scrollable = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabviewState();
}

class _TabviewState extends State<Tabview> {
  late int index = widget.index;
  late PageController controller = PageController(initialPage: widget.index);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [titles()];
    if (widget.divider) children.add(Dividers.line);
    Widget pv = PageView(controller: controller, children: widget.bodies);
    if (widget.scrollable) {
      children.add(Expanded(child: pv));
    } else {
      children.add(pv);
    }

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
          controller.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
