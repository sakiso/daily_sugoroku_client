import 'package:flutter/material.dart';

class SugorokuPage extends StatelessWidget {
  const SugorokuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // todo: appBarとかベースのScaffold切り出したい
      appBar: AppBar(
        title: const Text("daily sugoroku app!"),
      ),
      body: Center(
        child: Column(children: [
          const Text("sugoroku しようぜ"),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edit');
              },
              child: const Text("編集画面へ"))
        ]),
      ),
    );
  }
}
