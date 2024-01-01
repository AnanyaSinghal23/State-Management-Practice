import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//INFIX OPERATORS - in b/w operators
//state notifier-class having a state obj- can listen to the stream of obj-State_Notifier_Provider
void main() {
  runApp(
    const App(),
  );
}

extension OptionalInfixAddition<T extends num> on T? {
  T? operator + (T? other) {
    final shadow=this;
    if(shadow !=null) 
    {
      return shadow + (other??0) as T;
    }
    else
    {
      return null;
    }
  }
}

void TestIt()
{
  final int? int1=1;
  final int int2=1;
  final result=(int1??0)+int2;
  print(result);
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TestIt();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Home')),
      ),
    );
  }
}
