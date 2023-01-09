import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'components/time_picker.dart';

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
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("戻る"),
          ),
          const TimePicker(),
        ]),
      ),
    );
  }
}
