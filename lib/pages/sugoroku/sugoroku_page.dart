import 'package:flutter/material.dart';

class SugorokuPage extends StatelessWidget {
  const SugorokuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("daily sugoroku app!"),
      ),
      body: Center(
        child: Column(children: const [
          Text("sugoroku しようぜ"),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/edit');
        },
        // todo: 未登録と登録済みとでプラスと鉛筆のアイコン出し分けたい
        child: const Icon(Icons.edit),
      ),
    );
    // todo: ライフサイクルフックでSharedPreferencesを試しに使ってみる。どっちにしろ読み出し必要なので
    //       Hookを担うクラスを作って、Providerでデータを取って来たいね
    //       Providerの使い方とかはよくわかってないけど、描画とデータのやり取りとロジックは分離したい
    //       データの読み出しとかはpagesと同じレベルでディレクトリ切って外界との接点として分けて、
    //       ビジネスロジックはページと同じフォルダに入れとくか あまりにも共通的なのはcommonに入れる
  }
}
