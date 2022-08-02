import 'package:flutter/material.dart';

import '../util/router.dart';
import 'dividers.dart';

class Select extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final int index;
  final List<Widget> options;
  final void Function(int index) change;

  const Select({
    Key? key,
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    this.index = 0,
    required this.options,
    required this.change,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  late int index = widget.index;
  bool show = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          padding: widget.padding,
          child: Row(
            children: [
              Expanded(child: widget.options[index]),
              Icon(show ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined),
            ],
          ),
        ),
        onTap: () async {
          setState(() {
            show = true;
          });
          await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: options(),
            ),
          );
          setState(() {
            show = false;
          });
        },
      );

  List<Widget> options() {
    List<Widget> list = [];
    for (int i = 0; i < widget.options.length; i++) {
      if (i > 0) list.add(Dividers.line);
      List<Widget> option = [Expanded(child: widget.options[i])];
      if (i == index) {
        option.add(const Icon(Icons.check_outlined));
      }
      list.add(GestureDetector(
        child: Padding(
          padding: widget.padding,
          child: Row(children: option),
        ),
        onTap: () {
          setState(() {
            index = i;
          });
          widget.change(i);
          PageRouter.pop();
        },
      ));
    }

    return list;
  }
}
