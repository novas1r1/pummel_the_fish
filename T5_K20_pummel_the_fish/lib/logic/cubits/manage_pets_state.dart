part of "manage_pets_cubit.dart";

/// T5K20: State Management mit Bloc und Cubit
/// ManagePetsCubit in Variante 1
abstract class ManagePetsState extends Equatable {
  const ManagePetsState();

  @override
  List<Object> get props => [];
}

/// Initialer Zustand des [ManagePetsCubit]
class ManagePetsInitial extends ManagePetsState {}

/// Der [ManagePetsCubit] befindet sich im Ladezustand
class ManagePetsLoading extends ManagePetsState {}

/// Der [ManagePetsCubit] befindet sich im Erfolgszustand
/// Die [pets] sind die Kuscheltiere, die aus Firestore geladen wurden
class ManagePetsSuccess extends ManagePetsState {
  final List<Pet> pets;

  const ManagePetsSuccess({required this.pets});

  @override
  List<Object> get props => [pets];
}

/// Der [ManagePetsCubit] befindet sich im Fehlerzustand
class ManagePetsError extends ManagePetsState {}
