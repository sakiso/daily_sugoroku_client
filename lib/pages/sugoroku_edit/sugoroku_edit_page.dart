import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:numberpicker/numberpicker.dart';

class SugorokuEditPage extends StatelessWidget {
  const SugorokuEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("daily sugoroku app edit!"),
      ),
      body: Center(
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(hintText: '予定名'),
                ),
              ),
              NumberPicker(
                value: 0,
                minValue: 0,
                maxValue: 100,
                axis: Axis.horizontal,
                onChanged: (value) => (() => print(value)),
              ),
              const Text('時間'),
            ],
          ),
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
