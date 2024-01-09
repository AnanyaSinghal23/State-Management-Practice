import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//package: hooks_riverpod

final currentDate = Provider(
  (ref) => DateTime.now(),
);

class Ex1 extends ConsumerWidget {
  const Ex1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentDate);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Hooks Riverpod')),
      ),
      body: Center(
          child: Text(
        date.toString(),
        style: TextStyle(
          color: Colors.white,
        ),
      )),
    );
  }
}

//**error** Bad state: provider to be available to ur app.. under runapp

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home'),),
//     );
//   }
// }