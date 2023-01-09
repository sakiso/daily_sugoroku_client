import 'package:daily_sugoroku_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'components/time_picker.dart';

class SugorokuEditPage extends StatelessWidget {
  const SugorokuEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("編集画面"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 50.0,
                      child: TextFormField(
                        // todo: 長い文字を入れると下側が切れる(Mangaponであった事象)
                        // todo: 文字が上下中央寄せになっていない TextAlignVertical.centerしてるのに
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: '予定名を入力してください',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: ConstantColors.darkGray,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: ConstantColors.royalBlue,
                              width: 4.0,
                            ),
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ConstantColors.inactiveGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      // todo: 時間が設定されていなければ'00:00', 設定されたらその時間を表示
                      // todo: 時間が設定されたらフォントカラーや背景色をいい感じの色にする
                      child: const Text('所要時間'),
                      style: TextButton.styleFrom(
                        primary: Colors.black87,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return const TimePicker();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
              // todo: このへんにプラスボタンでフォーム増やせるようにする。forで回す数を増やす感じ？
            ),
            TextButton(
              child: const Text("戻る"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
