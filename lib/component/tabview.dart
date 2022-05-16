import 'package:flutter/material.dart';

class Tabview extends StatefulWidget {
  final int length;
  final bool tabScrollable;
  final List<Widget> Function() tabs;
  final List<Widget> Function(TabController controller) bodies;

  const Tabview({Key? key, required this.length, this.tabScrollable = false, required this.tabs, required this.bodies}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: SizedBox()),
                TabBar(
                  tabs: widget.tabs(),
                  controller: controller,
                  isScrollable: widget.tabScrollable,
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            children: widget.bodies(controller),
          ),
        ),
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
