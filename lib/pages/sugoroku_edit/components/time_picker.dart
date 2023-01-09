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

    return SizedBox(
      width: 260,
      child: Column(
        children: [
          Text(_formattedRequiredTime(_requiredTime)),
          ElevatedButton(
            child: const Text('1h'),
            style: ElevatedButton.styleFrom(
              primary: Constants.lightBlue,
              onPrimary: Colors.black,
              shape: const StadiumBorder(),
              fixedSize: const Size.fromWidth(double.maxFinite),
            ),
            onPressed: () {
              _addMinutes(ref, 60);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
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
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
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
      ),
    );
  }

  void _addMinutes(WidgetRef ref, int minutes) {
    // todo: 24:00以上になったら24:00で止まるようにする
    ref.read(_requiredTimeProvider.notifier).update((state) => state + minutes);
  }

  void _clearMinutes(WidgetRef ref) {
    ref.read(_requiredTimeProvider.notifier).state = 0;
  }

  String _formattedRequiredTime(int minutes) {
    // 例: input 135 -> output "02:15"
    final hoursString = (minutes / 60).floor().toString().padLeft(2, "0");
    final minutesString = (minutes % 60).toString().padLeft(2, "0");
    return "$hoursString:$minutesString";
  }
}
