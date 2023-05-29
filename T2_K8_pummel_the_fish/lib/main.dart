import 'package:flutter/material.dart';

void main() async {
  // T2K8: Vererbung in Dart
  // Verwendung der Animal-Klasse
  /* const dog = Animal(name: "Hund", age: 2);

  dog.bark();
  dog.miau();
  dog.blub();
  dog.piep();

  // Verwendung der Dog-Klasse
  final dogExtended = Dog(name: "Hund", age: 2);
  dogExtended.bark();
  dogExtended.greetReader(); */

  // T2K8: Mixins
  final dog = Dog();
  dog.walk();
  dog.swim();
  final cat = Cat();
  cat.walk();
  final fish = Fish();
  fish.swim();
  final bird = Bird();
  bird.fly();

  runApp(const MyApp());
}

// T2K8: Mixins
class Dog with WalkMixin, SwimMixin {}

class Cat with WalkMixin {}

class Fish with SwimMixin {}

class Bird with FlyMixin {}

// T2K8: Mixins
mixin WalkMixin {
  void walk() {
    print("Laufen");
  }
}
mixin SwimMixin {
  void swim() {
    print("Schwimmen");
  }
}
mixin FlyMixin {
  void fly() {
    print("Fliegen");
  }
}

// T2K8: Vererbung in Dart
/* class Dog extends Animal {
  Dog({required super.name, required super.age});

  @override
  void bark() {
    print("Wuff wuff");
  }
} */

// T2K8: Vererbung in Dart
/* class Animal {
  final String name;
  final int age;

  const Animal({required this.name, required this.age});

  void greetReader() {
    print("Hallo, ich bin $name und ich bin $age Jahre alt.");
  }

  void bark() {
    print("Wuff wuff");
  }

  void miau() {
    print("Miauuuu");
  }

  void blub() {
    print("Blubb blubb blubb");
  }

  void piep() {
    print("Piep piep");
  }
} */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        /// FLUTTER 3.10.X / DART 3.0: die Farbe wurde hier von primarySwatch auf colorScheme geändert
        /// auf das colorScheme geändert.
        /// ALT: primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

        /// FLUTTER 3.10.X / DART 3.0: useMaterial3 wurde hier hinzugefügt und auf true gesetzt
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pummel The Fish App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
