import 'package:clivia_base/util/upgrader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'notifier.dart';
import 'util/context.dart';
import 'util/http.dart';
import 'util/io.dart';

Future<void> init(Host host) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Io.init();
  await Context.init();
  Http.init(host);
}

class Main extends StatelessWidget {
  final String title;
  final Widget home;
  final List<ChangeNotifier>? notifiers;
  final List<LocalizationsDelegate<dynamic>>? delegates;

  const Main({Key? key, required this.title, required this.home, this.notifiers, this.delegates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChangeNotifierProvider> providers = [ChangeNotifierProvider<Notifier>.value(value: Notifier())];
    if (notifiers != null) {
      for (ChangeNotifier notifier in notifiers!) {
        providers.add(ChangeNotifierProvider<ChangeNotifier>.value(value: notifier));
      }
    }

    List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      S.delegate,
    ];
    if (delegates != null) {
      localizationsDelegates.addAll(delegates!);
    }

    return MultiProvider(
      providers: providers,
      child: Consumer<Notifier>(
        builder: (context, notifier, _) => MaterialApp(
          onGenerateTitle: (context) => title,
          debugShowCheckedModeBanner: false,
          theme: Context.theme,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: S.delegate.supportedLocales,
          localeListResolutionCallback: Context.localeCallback,
          locale: Context.locale,
          home: home,
          navigatorKey: Context.navigatorKey,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

class MainState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  int navigation = 0;

  @override
  void initState() {
    Upgrader.latest(context);
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          Context.orientation(orientation);

          return orientation == Orientation.portrait ? portrait() : landscape();
        },
      );

  Widget portrait() => Scaffold(
        body: body(),
        bottomNavigationBar: BottomNavigationBar(
          items: items(),
          type: BottomNavigationBarType.fixed,
          currentIndex: navigation,
          onTap: (int index) {
            setState(() {
              navigation = index;
            });
          },
        ),
      );

  List<BottomNavigationBarItem> items() {
    List<BottomNavigationBarItem> items = [];
    List<IconData> ids = icons();
    List<String> ls = labels();
    for (int i = 0; i < ids.length; i++) {
      items.add(BottomNavigationBarItem(
        icon: Icon(ids[i]),
        label: ls[i],
      ));
    }

    return items;
  }

  Widget landscape() => Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigation,
              destinations: destinations(),
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (int index) {
                setState(() {
                  navigation = index;
                });
              },
            ),
            Expanded(child: body()),
          ],
        ),
      );

  List<NavigationRailDestination> destinations() {
    List<NavigationRailDestination> destinations = [];
    List<IconData> ids = icons();
    List<String> ls = labels();
    for (int i = 0; i < ids.length; i++) {
      destinations.add(NavigationRailDestination(
        icon: Icon(ids[i]),
        label: Text(ls[i]),
      ));
    }

    return destinations;
  }

  Widget body() => const Center(
        child: Text('coming soon'),
      );

  List<IconData> icons() => [];

  List<String> labels() => [];
}
