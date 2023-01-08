import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _requiredTimeProvider = StateProvider<int>((ref) => 0);

class TimePicker extends ConsumerWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _requiredTime = ref.watch(_requiredTimeProvider);

    return Column(
      children: [
        Text("$_requiredTime"),
        TextButton(
          onPressed: () {
            ref
                .read(_requiredTimeProvider.notifier)
                .update((state) => state + 1);
          },
          child: const Text('+'),
        ),
        TextButton(
            onPressed: () {
              ref.read(_requiredTimeProvider.notifier).state = 0;
            },
            child: const Text('clear'))
      ],
    );
  }
}
