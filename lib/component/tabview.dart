import 'package:flutter/material.dart';

class Tabview extends StatefulWidget {
  final String? name;
  final String? title;
  final int length;
  final int index;
  final bool tabScrollable;
  final List<Widget> tabs;
  final List<Widget> bodies;
  static final Map<String, GlobalKey<ScaffoldState>> _map = {};

  Tabview({
    Key? key,
    this.name,
    this.title,
    required this.length,
    this.index = 0,
    this.tabScrollable = false,
    required this.tabs,
    required this.bodies,
  }) : super(key: key) {
    if (name != null) _map[name!] = GlobalKey<ScaffoldState>();
  }

  @override
  State<StatefulWidget> createState() => _TabviewState();

  static void setNavigation(String name, int navigation) {
    GlobalKey<ScaffoldState>? controllerKey = _map[name];
    if (controllerKey != null) {
      DefaultTabController.of(controllerKey.currentContext!)?.animateTo(navigation);
    }
  }
}

class _TabviewState extends State<Tabview> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: widget.length,
        initialIndex: widget.index,
        child: Scaffold(
          key: widget.name == null ? null : Tabview._map[widget.name],
          appBar: AppBar(
            title: widget.title == null ? null : Text(widget.title ?? ''),
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
