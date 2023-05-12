part of 'dogodki_bloc.dart';

@immutable
class DogodkiState {
  final bool initialized;
  final List<EventPayEvent>? cards;
  final Failure? failure;

  const DogodkiState({
    required this.initialized,
    required this.cards,
    required this.failure,
  });

  const DogodkiState.initial()
      : initialized = false,
        cards = null,
        failure = null;

  DogodkiState copyWith({
    bool? initialized,
    List<EventPayEvent>? cards,
    Failure? failure,
  }) {
    return DogodkiState(
      initialized: initialized ?? this.initialized,
      cards: cards ?? this.cards,
      failure: failure,
    );
  }
}
