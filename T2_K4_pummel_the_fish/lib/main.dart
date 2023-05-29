import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/models/owner.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/fake_pet_repository.dart';

void main() {
  // T2K4: Funktionen aufrufen
  final petRepository = FakePetRepository();
  final pets = petRepository.getAllPets();

  print(pets.length);

  // T2K4: chtung, statisch!
  final coolPetName = FakePetRepository.makeACoolPetName(
    "Dieter",
    titleOfNobility: "Sir",
    species: Species.cat,
    coolAdjective: "deadly",
  );

  print(coolPetName);

  final anotherCoolPetName = FakePetRepository.makeACoolPetName(
    "Petra",
    species: Species.dog,
  );

  print(anotherCoolPetName);

  // T2K4:  Null unter Kontrolle
  const svenjaOwner = Owner(id: "1", name: "Svenja");

  const pummelTheFish = Pet(
    id: "1",
    name: "Pummel",
    species: Species.fish,
    age: 3,
    weight: 200.0,
    height: 20.0,
    owner: svenjaOwner,
  );

  const brunoTheDog = Pet(
    id: "2",
    name: "Bruno",
    species: Species.dog,
    age: 4,
    weight: 320.0,
    height: 60.0,
  );

  final newPets = [
    pummelTheFish,
    brunoTheDog,
  ];

  for (final pet in newPets) {
    if (pet.owner != null) {
      print("${pet.name} gehört zu ${pet.owner!.name}");
    } else {
      print("${pet.name}'s Besitzer*in möchte anonym bleiben.");
    }

    // Kurzschreibweise
    print("${pet.name} gehört zu ${pet.owner?.name ?? "niemandem"}");
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
