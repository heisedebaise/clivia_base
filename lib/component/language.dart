import 'package:clivia_base/component/dividers.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  const Language({Key? key, this.icon = false, this.color}) : super(key: key);

  final bool icon;
  final Color? color;

  @override
  State createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String key = L10n.locale;

  @override
  Widget build(BuildContext context) => widget.icon ? icon() : list();

  Widget icon() => IconButton(
        onPressed: show,
        icon: Icon(
          Icons.language,
          color: widget.color,
        ),
      );

  Widget list() => ListTile(
        title: Text(l10n(context, 'language')),
        subtitle: Text(L10n.languages[key] ?? ''),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: show,
      );

  void show() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        List<Widget> list = [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(l10n(context, 'language.select')),
          ),
        ];
        for (String key in L10n.languages.keys) {
          list.add(Dividers.line);
          list.add(item(key));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: list,
        );
      },
    );
  }

  Widget item(String key) => ListTile(
        title: Text(L10n.languages[key] ?? ''),
        trailing: key == this.key ? const Icon(Icons.check) : null,
        onTap: () async {
          setState(() {
            this.key = key;
          });
          await L10n.setLocale(context, key);
        },
      );
}
