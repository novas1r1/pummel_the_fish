import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/firestore_pet_repository.dart";

part "manage_pets_state.dart";

/// T5K20: State Management mit Bloc und Cubit
/// ManagePetsCubit in Variante 1
class ManagePetsCubit extends Cubit<ManagePetsState> {
  /// Der [firestorePetRepository] wird benötigt, um Daten aus Firestore zu laden
  final FirestorePetRepository firestorePetRepository;

  /// Der Konstruktor des [ManagePetsCubit] erwartet ein [firestorePetRepository]
  ManagePetsCubit(this.firestorePetRepository) : super(ManagePetsInitial());

  /// Mit der Methode [getAllPets] werden alle Kuscheltiere aus Firestore geladen
  /// emits [ManagePetsLoading] wenn das Laden beginnt
  /// emits [ManagePetsSuccess] wenn das Laden erfolgreich war
  /// emits [ManagePetsError] wenn das Laden fehlgeschlagen ist
  Future<void> getAllPets() async {
    emit(ManagePetsLoading());

    try {
      final pets = await firestorePetRepository.getAllPets();
      emit(ManagePetsSuccess(pets: pets));
    } on Exception {
      emit(ManagePetsError());
    }
  }
}
