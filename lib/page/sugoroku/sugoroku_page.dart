import 'package:flutter/material.dart';

class SugorokuPage extends StatelessWidget {
  const SugorokuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sugorokuLayout();
  }

  Widget sugorokuLayout() {
    return Center(
        child: Column(children: const <Widget>[
      Text("Sugoroku画面"),
    ]));
  }
}
