import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//future, state, watching another provider

enum City {
  stockholm,
  paris,
  tokyo,
}

//**
typedef WeatherEmoji = String;

//during the delay, the circular progress gets 
Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.stockholm: '❄',
      City.paris: '🌧',
      City.tokyo: '💨',
    }[city]!,
  );
}

//state provider: keeps hold of value that can be CHANGED
//will be changed by the UI
//UI writes to and reads from this - reading about the chosen city
final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);

const unknownweatheremoji = '☁';

//UI reads this
final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return unknownweatheremoji;
  }
});

class Ex3 extends ConsumerWidget {
  const Ex3({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //async value
    final currentWeather = ref.watch(
      weatherProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Column(
        children: [
          currentWeather.when(
            data: (data) => Text(
              data,
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            error: (_, __) => const Text('Error :('),
            loading: () => const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final city = City.values[index];
                final isSelected = city == ref.watch(currentCityProvider);
                return ListTile(
                  title: Text(city.toString()),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () {
                    ref.read(currentCityProvider.notifier).state = city;
                  },
                );
              },
              itemCount: City.values.length,
            ),
          )
        ],
      ),
    );
  }
}
