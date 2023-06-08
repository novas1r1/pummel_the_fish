import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/firestore_pet_repository.dart';

part 'manage_pets_simple_state.dart';

/// T5K20: State Management mit Bloc und Cubit
/// ManagePetsCubit in Variante 2
class ManagePetsSimpleCubit extends Cubit<ManagePetsSimpleState> {
  /// Der [firestorePetRepository] wird benötigt, um Daten aus Firestore zu laden
  final FirestorePetRepository firestorePetRepository;

  /// Der Konstruktor des [ManagePetsCubit] erwartet ein [firestorePetRepository]
  ManagePetsSimpleCubit(this.firestorePetRepository)
      : super(const ManagePetsSimpleState());

  /// Mit der Methode [getAllPets] werden alle Kuscheltiere aus Firestore geladen
  /// emits [ManagePetsStatus.loading] wenn das Laden beginnt
  /// emits [ManagePetsStatus.success] wenn das Laden erfolgreich war
  /// emits [ManagePetsStatus.error] wenn das Laden fehlgeschlagen ist
  Future<void> getAllPets() async {
    emit(state.copyWith(status: ManagePetsStatus.loading));

    try {
      final pets = await firestorePetRepository.getAllPets();

      emit(state.copyWith(status: ManagePetsStatus.success, pets: pets));
    } on Exception catch (ex) {
      emit(
        state.copyWith(
          status: ManagePetsStatus.error,
          errorMessage: ex.toString(),
        ),
      );
    }
  }

  Future<void> deletePet(String id) async {
    emit(state.copyWith(status: ManagePetsStatus.loading));

    try {
      // delete pet
      await firestorePetRepository.deletePetById(id);

      // fetch pets again
      final pets = await firestorePetRepository.getAllPets();

      emit(state.copyWith(
        status: ManagePetsStatus.deleteSuccess,
        pets: pets,
      ));
    } on Exception catch (ex) {
      emit(
        state.copyWith(
          status: ManagePetsStatus.deleteError,
          errorMessage: ex.toString(),
        ),
      );
    }
  }

  Future<void> updatePet(Pet updatedPet) async {
    emit(state.copyWith(status: ManagePetsStatus.loading));

    try {
      // update pet
      await firestorePetRepository.updatePet(updatedPet);
      final pets = await firestorePetRepository.getAllPets();

      emit(state.copyWith(
        status: ManagePetsStatus.updateSuccess,
        pets: pets,
      ));
    } on Exception catch (ex) {
      emit(
        state.copyWith(
          status: ManagePetsStatus.updateError,
          errorMessage: ex.toString(),
        ),
      );
    }
  }
}
