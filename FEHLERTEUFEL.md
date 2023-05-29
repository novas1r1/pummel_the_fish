# Fehlerteufel

- S.68 (Listing 4.20) - Falscher Import Pfad
    - Falsch: import *'package:adopt_a_pet/data/models/pet.dart';*
    - Richtig: import *'package:pummel_the_fish/data/models/pet.dart';*
- S.75 (Listing 4.28) - Fehlendes Semikolon
    - Falsch: *titleOfNobility = titleOfNobility ?? "",*
    - Richtig: *titleOfNobility = titleOfNobility ?? "";*
- S.80 (Listing 4.37) - Falsches Zeichen
    - Falsch: *print("${pet.name}"s Besitzer-in möchte anonym bleiben.");*
    - Richtig: *print("${pet.name}’s Besitzer-in möchte anonym bleiben.");*
- S.84 (Listing 5.3) - Semikolon fehlt
    - Falsch: *print("Pummel ist ein Fisch.")*
    - RIchtig: *print("Pummel ist ein Fisch.");*
- S.94 (Listing 7.3) - Fehlende Klammern für Methodenaufruf
    - Falsch: *getPet.then((pet) => print(pet));*
    - RIchtig: *getPet().then((pet) => print(pet));*
- S.95 - Falsch Benennung
    - Falsch: *foodDeliverySubscription.cancel();*
    - Richtig: *foodStreamSubscription.cancel();*
- S.98 (Listing 8.4) - Doppelpunkt am Ende falsch
    - Falsch: *Dog({required super.name, required super.age}):*
    - Richtig: *Dog({required super.name, required super.age});*
- S.101 (Listing 8.8) - updatePet(Pet pet) Methode fehlt
    - Falsch:
    ```dart
    abstract class PetRepository {
	    Pet? getPetById(String id);
	    List<Pet> getAllPets();
	    void addPet();
	    void deletePetById(String id);
    }
    ```
    - Richtig:
    ```dart
    abstract class PetRepository {
	    Pet? getPetById(String id);
	    List<Pet> getAllPets();
	    void addPet(Pet pet);
	    void deletePetById(String id);
	    void updatePet(Pet pet);
    }
   ```
- S.101 (Listing 8.9) - Fehlende, falsche Methoden
    - Falsch:
    ```dart
    class FakePetRepository implements PetRepository {
        @override
        Pet? getPetById(String id) { ... }
        @override
        List<Pet> getAllPets() { ... }
        @override
        void addPet() { ... }
        @override
        void deletePetById(String id) { ... }
    }
    ```
    - Richtig:
    ```dart
    class FakePetRepository implements PetRepository {
        @override
        Pet? getPetById(String id) { ... }
        @override
        List<Pet> getAllPets() { ... }
        @override
        void addPet(Pet pet) { ... }
        @override
        void deletePetById(String id) { ... }
        @override
        void updatePet(Pet pet) { ... }
    }
    ```
- S.147 (Listing 11.16): - Leerzeichen im Pfad
    - Falsch: *child: Image.asset("assets/images/logo.png "),*
    - Richtig: *child: Image.asset("assets/images/logo.png"),*
- S.184 (Listing 11.53) - Fehlendes Semikolon am Ende
    - Falsch:
    ```dart
    validator: (value) {
	    return value == null? "Bitte eine Spezies angeben": null,
    }
    ```
    - Richtig:
    ```dart
    validator: (value) {
        return value == null? "Bitte eine Spezies angeben": null;
    }
    ```
- S.190 (Listing 12.3) - Großbuchstabe zu Beginn
    - Falsch: *Class _InfoCard extends StatelessWidget {*
    - Richtig: *class _InfoCard extends StatelessWidget {*
- S.191 (Listing 12.4) - Großbuchstabe zu Beginn
    - Falsch: *Import "package:flutter/material.dart";*
    - Richtig: i*mport "package:flutter/material.dart";*
- S.226 (Listing 15.9)
    - Falsch: *Icon(FontAwesomeIcons.fish,color: CustomColors.blueMedium,),*
    - Richtig: Komplett entfernen, da FontAwesome nicht beschrieben wurde
- S.246 (Listing 16.2) - Methoden fehlt
    - Falsch: Methode getPetById(String id) fehlt
    - Richtig:
    ```dart
    @override  
    Pet? getPetById(String id) { ... }
    ```
- S.249 (Listing 16.6) - Methoden falsch
    - Falsch:
    ```dart
    import "dart:async";
    import "package:pummel_the_fish/data/models/pet.dart";

    abstract class PetRepository {  
        FutureOr<List<Pet>> getAllPets();  
        FutureOr<void> addPet(Pet pet);  
        FutureOr<void> updatePetById(Pet pet);  
        FutureOr<void> deletePetById(Pet pet);  
    }
    ```
    - Richtig:
    ```dart
    import "dart:async";
    import "package:pummel_the_fish/data/models/pet.dart";

    abstract class PetRepository {  
        FutureOr<List<Pet>> getAllPets();  
        FutureOr<void> addPet(Pet pet);  
        FutureOr<void> updatePet(Pet pet);  
        FutureOr<void> deletePetById(String id);  
        FutureOr<Pet?> getPetById(String id);
    }
    ```
- S.286 (Listing 17.4) - durch Flutter/Dart/Firebase Update nicht mehr gültig
    - Alt:
    ```dart
    @override  
    Future<void> addPet(Pet pet) async {    
        final emptyDocument = await firestore.collection(petCollection).add();
        final petWithId = Pet(
            id: docId.id,      
                    name: pet.name,
            species: pet.species,
            age: pet.age,
            weight: pet.weight,
            height: pet.height,
            isFemale: pet.isFemale,
            owner: pet.owner,
        );    
        emptyDocument.set(petWithId.toMap());  
    }
    ```
    - Neu:
    ```dart
    @override  
    Future<void> addPet(Pet pet) async {    
        final emptyDocument = await firestore.collection(petCollection).add({});
        final petWithId = Pet(
            id: emptyDocument.id,      
                    name: pet.name,
            species: pet.species,
            age: pet.age,
            weight: pet.weight,
            height: pet.height,
            isFemale: pet.isFemale,
            owner: pet.owner,
        );    
        emptyDocument.set(petWithId.toMap());  
    }
    ```
- S.293 (Listing 17.11) - fromJson Methode gibt es nicht, nur fromMap
    - Falsch: *final petList = petsSnapshot.docs.map((doc) => Pet.fromJson(jsonEncode(doc.data()),)).toList();*
    - Richtig: *final petList = petsSnapshot.docs.map((doc) => Pet.fromMap(doc.data()),).toList();*
- S.293 (Listing 17.12) - Falsche Benennung, fromJson Methode gibt es nicht
    - Falsch:
    ```dart
    Future<List<Pet>> getPetsOrderedByHeight() async {
        final petsSnapshot = await _firestore.collection(petCollection).orderBy("height", descending: true).get();
        final petList = petsSnapshot.docs.map((doc) => Pet.fromJson(jsonEncode(doc.data()))).toList();
        
        return petList;
    }
    ```
    - Richtig:
    ```dart
    Future<List<Pet>> getPetsOrderedByHeight() async {
        final petsSnapshot = await firestore.collection(petCollection).orderBy("height", descending: true).get();
        final petList = petsSnapshot.docs.map((doc) => Pet.fromMap(doc.data())).toList();
        
        return petList;
    }
    ```
- S.295 (Listing 17.14) - Falsche Benennung von Variable und Methode
    - Falsch: *pets = firestorePetRepository.getAllPetsAsStream();*
    - Richtig: *petStream = firestorePetRepository.getPetsStream();*
- S.311 (Listing 19.2) - Darf nicht const sein
    - Falsch: *actions: const [AdoptionBag(petCount: petCount),],*
    - Richtig: *actions: [AdoptionBag(petCount: petCount),],*
- S.334 (Listing 20.16) - Klammer fehlt nach int>
    - Falsch:
    ```dart
    BlocSelector<ManagePetsCubit, ManagePetsState, int>
        selector: (state) {
            if (state is ManagePetsSuccess) {
                return state.currentPetAmount;
            }
            return 0;
        },
        builder: (context, currentPetAmount) {
            return const Text("$currentPetAmount");
        },
    ),
    ```
    - Richtig:
    ```dart
    BlocSelector<ManagePetsCubit, ManagePetsState, int>(
        selector: (state) {
            if (state is ManagePetsSuccess) {
                return state.currentPetAmount;
            }                    
            return 0;                  
        },                  
        builder: (context, currentPetAmount) {
            return Text("$currentPetAmount");
        },
    ),
    ```
- S.335 (Listing 20.18) - Falsche Benennung
    - Falsch:
    ```dart
    create: (context) => FirestorePetRepository(
	    firebaseFirestore: FirebaseFirestore.instance,
    ),
    ```
    - Richtig:
    ```dart
    create: (context) => FirestorePetRepository(
        firestore: FirebaseFirestore.instance,
    ),
    ```
- S.338 (Listing 20.25) - Falsche Benennung
    - Falsch:
    ```dart
    class ManagePetsCubit extends Cubit<ManagePetsState> {
	final FirestorePetRepository petRepository;

	ManagePetsCubit({required this.petRepository}): 
		super(const ManagePetsState());
    ```
    - Richtig:
    ```dart
    class ManagePetsCubit extends Cubit<ManagePetsState> {
	final FirestorePetRepository firestorePetRepository;

	ManagePetsCubit(this.firestorePetRepository): 
		super(const ManagePetsState());
    ```
- S. 359 (Listing 21.15) - Falsche Variable
    - Falsch: *expect(result, tPets);*
    - Richtig: *expect(result, tPetList);*
- S.364 (Listing 21.20) - Falscher Import Pfad
    - Falsch: *import "package:pummel_the_fish/cubits/manage_pets_cubit.dart";*
    - Richtig: *import "package:pummel_the_fish/logic/cubits/manage_pets_cubit.dart";*
- S. 368 (Listing 21.25) - Falscher Text
    - Falsch: *expect(find.text("Space"), findsOneWidget);*
    - Richtig: *expect(find.text("Harribart"), findsOneWidget);*
- S.372 MultiDex Support
    - Falsch: multiDexEnabled
    - Richtig: multiDexEnabled true