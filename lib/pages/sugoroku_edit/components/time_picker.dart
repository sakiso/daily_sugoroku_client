import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => new _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  var hoge = 0;

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      value: hoge,
      minValue: 0,
      maxValue: 100,
      axis: Axis.horizontal,
      onChanged: (value) => setState(() => hoge = value),
    );
  }
}

// ↑のStatefulWidgetを使うとうまくいく
// ↓のProvider使うパターンだとうまくいかない。多分値の更新ができてない？戻ってしまう

// StateProvider<int> _requiredTimeProvider = StateProvider((ref) => 0);

// class TimePicker extends ConsumerWidget {
//   const TimePicker({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     int _requiredTime = ref.watch(_requiredTimeProvider);

//     return NumberPicker(
//       value: _requiredTime,
//       minValue: 0,
//       maxValue: 100,
//       axis: Axis.horizontal,
//       onChanged: (val) => {print("val")},
//       // onChanged: (value) {
//       //   print("new: ${value}");
//       //   print("old: ${_requiredTime}");
//       //   _requiredTime = value;
//       // },
//     );
//   }
// }
