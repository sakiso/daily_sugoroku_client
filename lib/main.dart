import 'package:flutter/material.dart';

import 'page/sugoroku/sugoroku_page.dart';
import 'page/sugoroku_edit/sugoroku_edit_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'daily sugoroku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        // todo: lib下のconstファイルに切り出せたらいいかも
        '/': (context) => const SugorokuPage(),
        '/edit': (context) => const SugorokuEditPage(),
      },
    );
  }
}
