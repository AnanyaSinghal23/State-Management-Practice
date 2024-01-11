import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
//add uuid- multiple info to be saved

@immutable class Person {
  final String name;
  final int age;
  final String uuid;

  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) => Person(name: name ?? this.name,
  age: age?? this.age,
  uuid: uuid,);

  String get displayName => '$name ($age years old)';

  @override 
  bool operator == (covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() => 'Person(name: $name, age: $age, uuid: $uuid)';
}

//change notifier: class that is able to store most complex obj-> tells something has changed, not the exact changes
class DataModel extends ChangeNotifier{
  final List<Person> _people = [];
  int get count => _people.length;

  //not allowed to change obj
  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void addPerson(Person person){
    _people.add(person);
    notifyListeners();
  }
}

class Ex5 extends ConsumerWidget {
  const Ex5({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person'),
      ),
    );
  }
}
