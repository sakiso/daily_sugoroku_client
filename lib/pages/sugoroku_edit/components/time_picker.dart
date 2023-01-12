import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Constants.dart';
import '../../../repositories/plan_repository.dart';

final _requiredTimeProvider = StateProvider.autoDispose<int>((ref) => 0);
// note: autoDispose修飾子を付けることで画面がpopされたときステートも破棄される

class TimePicker extends ConsumerWidget {
  // todo: 数字キー入力もできるようにしたい
  const TimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _requiredTime = ref.watch(_requiredTimeProvider);

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              _formattedRequiredTime(_requiredTime),
              style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 73,
                  color: ConstantColors.darkGray),
            ),
            ElevatedButton(
              child: const Text('Clear'),
              style: ElevatedButton.styleFrom(
                primary: ConstantColors.inactiveGray,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
                fixedSize: const Size.fromWidth(170.0),
              ),
              onPressed: () {
                _clearMinutes(ref);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: const Text(
                '+ 1:00',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: ConstantColors.lightBlue,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
                fixedSize: const Size(double.maxFinite, 50.0),
              ),
              onPressed: () {
                _addMinutes(ref, 60);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text(
                      '+ 0:30',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: ConstantColors.lightBlue,
                        onPrimary: Colors.black,
                        shape: const StadiumBorder(),
                        fixedSize: const Size.fromHeight(50.0)),
                    onPressed: () {
                      _addMinutes(ref, 30);
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ElevatedButton(
                    child: const Text(
                      '+ 0:15',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ConstantColors.lightBlue,
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
              height: 10,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("キャンセル"),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text("OK"),
          // todo: 押すとProvider経由でStorageにデータを保存する
          onPressed: () {
            PlanRepository().fetchPlans();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void _addMinutes(WidgetRef ref, int minutes) {
    final currentRequiredTime = ref.read(_requiredTimeProvider);
    // 1440分(=24時間)を超えないよう早期リターン
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
