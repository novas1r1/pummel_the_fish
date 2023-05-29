import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/models/pet.dart';

void main() {
  // T2K5: Bedingte Anweisungen und Schleifen im Griff
  const pummelTheFish = Pet(
    id: "1",
    name: "Pummel",
    species: Species.fish,
    age: 3,
    weight: 200.0,
    height: 20.0,
  );

  const hansiTheBird = Pet(
    id: "5",
    name: "Hansi",
    species: Species.bird,
    age: 1,
    weight: 100.0,
    height: 10.0,
  );

  // T2K5: if und else - wenn ich könnte, würde ich ja ...
  // Mit if-else
  if (pummelTheFish.species == hansiTheBird.species) {
    print("Gleiche Spezies – Züchten möglich");
  } else {
    print("Ungleiche Spezies – Züchten nicht möglich");
  }

  // T2K5: if und else - wenn ich könnte, würde ich ja ...
  // Mit Ternary Operator
  pummelTheFish.species == hansiTheBird.species
      ? print("Gleiche Spezies – Züchten möglich")
      : print("Ungleiche Spezies – Züchten nicht möglich");

  // T2K5: if und else - wenn ich könnte, würde ich ja ...
  // Mit if-else if-else
  if (pummelTheFish.species == Species.dog) {
    print("Pummel ist ein Hund.");
  } else if (pummelTheFish.species == Species.cat) {
    print("Pummel ist eine Katze.");
  } else if (pummelTheFish.species == Species.fish) {
    print("Pummel ist ein Fisch.");
  }

  // T2K5: if und else - wenn ich könnte, würde ich ja ...
  // Mit Ternary Operator
  (pummelTheFish.species == Species.dog)
      ? print("Pummel ist ein Hund.")
      : (pummelTheFish.species == Species.cat)
          ? print("Pummel ist eine Katze.")
          : (pummelTheFish.species == Species.fish)
              ? print("Pummel ist ein Fisch.")
              : print("Pummel gehört keiner Spezies an.");

  // T2K5: Switch - wer die Wahl hat, hat die Qual
  const brunoTheDog = Pet(
    id: "2",
    name: "Bruno",
    species: Species.dog,
    age: 4,
    weight: 320.0,
    height: 60.0,
  );

  switch (brunoTheDog.species) {
    case Species.dog:
      print("Bruno ist ein Hund.");
      break;
    case Species.cat:
      print("Bruno ist eine Katze.");
      break;
    case Species.bird:
      print("Bruno ist ein Vogel.");
      break;
    case Species.fish:
      print("Bruno ist ein Fisch.");
      break;
  }

  runApp(const MyApp());
}

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
