import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<int> _requiredTimeProvider = StateProvider((ref) => 0);

class TimePicker extends ConsumerWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _requiredTime = ref.watch(_requiredTimeProvider);

    return Text("$_requiredTime");
  }
}
