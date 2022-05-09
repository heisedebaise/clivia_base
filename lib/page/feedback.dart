import 'package:flutter/material.dart';

import '../component/popage.dart';
import '../util/l10n.dart';
import '../util/router.dart';

class FeedBack extends StatelessWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(l10n(context, 'feedback')),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          PageRouter.push(const FeedBackPage());
        },
      );
}

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => PopPage(
        close: true,
        title: l10n(context, 'feedback'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n(context, 'feedback.memo'),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 99,
                    maxLines: 999,
                    autofocus: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      isDense: true,
                      border: OutlineInputBorder(
                        gapPadding: 0,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    controller: controller,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(l10n(context, 'submit')),
                ),
              ),
            ],
          ),
        ),
      );
}
