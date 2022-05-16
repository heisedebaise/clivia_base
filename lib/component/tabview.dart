import 'package:flutter/material.dart';

class Tabview extends StatefulWidget {
  final int length;
  final List<Widget> Function() tabs;
  final List<Widget> Function(TabController controller) body;

  const Tabview({Key? key, required this.length, required this.tabs, required this.body}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabviewState();
}

class _TabviewState extends State<Tabview> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: widget.length, vsync: this);
    controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                TabBar(
                  tabs: widget.tabs(),
                  controller: controller,
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            children: widget.body(controller),
          ),
        ),
      );
}
