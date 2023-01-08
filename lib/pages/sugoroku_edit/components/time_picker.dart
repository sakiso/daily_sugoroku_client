import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';

final _requiredTimeProvider = StateProvider.autoDispose<int>((ref) => 0);
// note: autoDispose修飾子を付けると画面がpopされたときステートも破棄される

class TimePicker extends ConsumerWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _requiredTime = ref.watch(_requiredTimeProvider);

    return Column(
      children: [
        // todo: hh:mm形式にする
        Text("$_requiredTime"),
        // todo: 1hボタンの横幅長くしたい
        ElevatedButton(
          child: const Text('1h'),
          style: ElevatedButton.styleFrom(
            primary: Constants.lightBlue,
            onPrimary: Colors.black,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            _addMinutes(ref, 60);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('30min'),
              style: ElevatedButton.styleFrom(
                primary: Constants.lightBlue,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                _addMinutes(ref, 30);
              },
            ),
            // todo: 1hボタンの幅に連動するようにスペース上けたい
            ElevatedButton(
              child: const Text('15min'),
              style: ElevatedButton.styleFrom(
                primary: Constants.lightBlue,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                _addMinutes(ref, 15);
              },
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            _addMinutes(ref, 1);
          },
          child: const Text('+'),
        ),
        TextButton(
            onPressed: () {
              _clearMinutes(ref);
            },
            child: const Text('clear'))
      ],
    );
  }

  void _addMinutes(WidgetRef ref, int minutes) {
    // todo: 24:00以上になったら24:00で止まるようにする
    ref.read(_requiredTimeProvider.notifier).update((state) => state + minutes);
  }

  void _clearMinutes(WidgetRef ref) {
    ref.read(_requiredTimeProvider.notifier).state = 0;
  }
}
