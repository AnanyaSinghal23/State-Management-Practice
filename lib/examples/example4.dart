import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//streams: reactive pipe of data...

const names = [
  'Ananya',
  'Manya',
  'Aarohi',
  'Meera',
  'Riddhi',
  'Shipra',
  'Gaurisha',
];

//index increases with time
final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(
      seconds: 1,
    ),
    (i) => i + 1,
  ),
);

// final namesProvider = StreamProvider((ref) {
//   final a = ref.watch(tickerProvider.stream).map((count) => names.getRange(0, count))
// });

final namesProvider = StreamProvider((ref) =>
    ref.watch(tickerProvider.stream).map((count) => names.getRange(0, count)));

class Ex4 extends ConsumerWidget {
  const Ex4({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream'),
      ),
      body: names.when(
        data: (names) {
          return ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(names.elementAt(index)),
              );
            },);
        },
        error: (error, stackTrace) => const Text('End of List!'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
