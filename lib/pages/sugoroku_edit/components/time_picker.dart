import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      value: 0,
      minValue: 0,
      maxValue: 100,
      axis: Axis.horizontal,
      onChanged: (value) => (() => print(value)),
    );
  }
}
