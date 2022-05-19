import 'package:flutter/material.dart';

class Tabview extends StatefulWidget {
  final int length;
  final bool tabScrollable;
  final List<Widget> tabs;
  final List<Widget> bodies;

  const Tabview({Key? key, required this.length, this.tabScrollable = false, required this.tabs, required this.bodies}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabviewState();
}

class _TabviewState extends State<Tabview> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: widget.length,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: SizedBox()),
                  TabBar(
                    tabs: widget.tabs,
                    isScrollable: widget.tabScrollable,
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: widget.bodies,
            ),
          ),
        ),
      );
}
