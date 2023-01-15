import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Constants.dart';
import '../../../repositories/plan_repository.dart';
import '../../../utilities/format_minutes_to_hhmm.dart';

final _requiredMinutesProvider =
    StateProvider.autoDispose<int>((ref) => 0); // todo: providersに切り出すか
// note: autoDispose修飾子を付けることで画面がpopされたときステートも破棄される

class TimePicker extends ConsumerWidget {
  // todo: 数字キー入力もできるようにしたい
  // todo: 角はもうちょっと丸めたい
  const TimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _requiredMinutes = ref.watch(_requiredMinutesProvider);

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              _formattedRequiredMinutes(_requiredMinutes),
              style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 73,
                  color: ConstantColors.darkGray),
            ),
            ElevatedButton(
              child: const Text('Clear'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: ConstantColors.inactiveGray,
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
                foregroundColor: Colors.black,
                backgroundColor: ConstantColors.lightBlue,
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
                        foregroundColor: Colors.black,
                        backgroundColor: ConstantColors.lightBlue,
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
                      foregroundColor: Colors.black,
                      backgroundColor: ConstantColors.lightBlue,
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
          onPressed: () {
            // todo: provider経由で更新
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void _addMinutes(WidgetRef ref, int minutes) {
    final currentRequiredMinutes = ref.read(_requiredMinutesProvider);
    // 1440分(=24時間)を超えないよう早期リターン
    if (currentRequiredMinutes + minutes > 1440) {
      return;
    }
    ref
        .read(_requiredMinutesProvider.notifier)
        .update((state) => state + minutes);
  }

  void _clearMinutes(WidgetRef ref) {
    ref.read(_requiredMinutesProvider.notifier).state = 0;
  }

  String _formattedRequiredMinutes(int minutes) {
    return formatMinutesToHHMM(minutes);
  }
}
