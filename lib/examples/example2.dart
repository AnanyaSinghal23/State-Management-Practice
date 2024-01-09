import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(0);
  void increment() => state = state == 0 ? 1 : state + 1;
  int? get value => state;
}

final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

class Ex2 extends ConsumerWidget {
  const Ex2({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // //as the value changes, the whole scaffold builds again -- computational power waste
    // final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            //only title will be recalc
            final count = ref.watch(counterProvider);
            final text = count == null? 'Press the button' : count.toString();
            return Text(text);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            // onPressed: ref.read(counterProvider.notifier).increment,
            onPressed: () {
              //gets current snapshot of the data
              ref.read(counterProvider.notifier).increment();
            },
            child: const Text(
              'Increment Counter',
            ),
          )
        ],
      ),
    );
  }
}