part of "manage_pets_simple_cubit.dart";

/// ManagePetsCubit in Variante 2
enum ManagePetsStatus {
  initial,
  loading,
  success,
  error,
}

/// ManagePetsCubit in Variante 2
class ManagePetsSimpleState extends Equatable {
  /// Der [status] gibt an, in welchem Zustand sich der [ManagePetsSimpleCubit] befindet
  final ManagePetsStatus status;

  /// Die [pets] sind die Kuscheltiere, die aus Firestore geladen wurden
  final List<Pet> pets;

  /// Die [errorMessage] wird gesetzt, wenn ein Fehler auftritt
  final String? errorMessage;

  const ManagePetsSimpleState({
    this.status = ManagePetsStatus.initial,
    this.pets = const [],
    this.errorMessage,
  });

  ManagePetsSimpleState copyWith({
    ManagePetsStatus? status,
    List<Pet>? pets,
    String? errorMessage,
  }) {
    return ManagePetsSimpleState(
      status: status ?? this.status,
      pets: pets ?? this.pets,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, pets, errorMessage];
}
