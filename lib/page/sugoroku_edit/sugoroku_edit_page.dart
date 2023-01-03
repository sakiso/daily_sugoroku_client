import 'package:flutter/material.dart';

class SugorokuEditPage extends StatelessWidget {
  const SugorokuEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // todo: appBarとかベースのScaffold切り出したい
      appBar: AppBar(
        title: const Text("daily sugoroku app edit!"),
      ),
      body: Center(
        child: Column(children: [
          const Text("sugoroku 編集 しようぜ"),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("戻る"))
        ]),
      ),
    );
  }
}
