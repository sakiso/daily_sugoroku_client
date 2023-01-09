import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';

final _requiredTimeProvider = StateProvider.autoDispose<int>((ref) => 0);
// note: autoDispose修飾子を付けることで画面がpopされたときステートも破棄される

class TimePicker extends ConsumerWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _requiredTime = ref.watch(_requiredTimeProvider);

    return SizedBox(
      width: 260,
      child: Column(
        children: [
          Text(
            _formattedRequiredTime(_requiredTime),
            style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 85,
                color: Constants.darkGray),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            child: const Text('1h'),
            style: ElevatedButton.styleFrom(
              primary: Constants.lightBlue,
              onPrimary: Colors.black,
              shape: const StadiumBorder(),
              fixedSize: const Size(double.maxFinite, 50.0),
            ),
            onPressed: () {
              _addMinutes(ref, 60);
            },
          ),
          const SizedBox(
            height: 20,
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
                      fixedSize: const Size.fromHeight(50.0)),
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
                    fixedSize: const Size.fromHeight(50.0),
                  ),
                  onPressed: () {
                    _addMinutes(ref, 15);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  child: const Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    primary: Constants.inactiveGray,
                    onPrimary: Colors.black,
                    shape: const StadiumBorder(),
                    fixedSize: const Size.fromHeight(50.0),
                  ),
                  onPressed: () {
                    _clearMinutes(ref);
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  child: const Text('OK'),
                  style: ElevatedButton.styleFrom(
                    primary: Constants.green,
                    onPrimary: Colors.black,
                    shape: const StadiumBorder(),
                    fixedSize: const Size.fromHeight(50.0),
                  ),
                  onPressed: () {
                    // todo: 押すとProvider経由でStorageにデータを保存する
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addMinutes(WidgetRef ref, int minutes) {
    // todo: 24:00以上になったら24:00で止まるようにする
    final currentRequiredTime = ref.read(_requiredTimeProvider);
    if (currentRequiredTime + minutes > 1440) {
      return;
    }
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
