import 'package:flutter/material.dart';

class Tabview extends StatefulWidget {
  final String? name;
  final int length;
  final int index;
  final bool tabScrollable;
  final List<Widget> tabs;
  final List<Widget> bodies;
  final GlobalKey<ScaffoldState> _controllerKey = GlobalKey<ScaffoldState>();
  static final Map<String, GlobalKey<ScaffoldState>> _map = {};

  Tabview({Key? key, this.name, required this.length, this.index = 0, this.tabScrollable = false, required this.tabs, required this.bodies}) : super(key: key) {
    if (name != null) {
      _map[name!] = _controllerKey;
    }
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
          key: widget._controllerKey,
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
