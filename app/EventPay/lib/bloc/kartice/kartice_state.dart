part of 'kartice_bloc.dart';

@immutable
class KarticeState {
  final bool initialized;
  final List<EventPayCard>? cards;
  final bool? isSuccessful;
  final EventPayCard? selectedCard;

  const KarticeState({
    required this.initialized,
    required this.cards,
    required this.isSuccessful,
    this.selectedCard,
  });

  const KarticeState.initial()
      : initialized = false,
        cards = null,
        isSuccessful = null,
        selectedCard = null;

  KarticeState copyWith(
      {bool? initialized, List<EventPayCard>? cards, bool? isSuccessful, EventPayCard? selectedCard}) {
    return KarticeState(
      initialized: initialized ?? this.initialized,
      cards: cards ?? this.cards,
      isSuccessful: isSuccessful ?? this.isSuccessful,
      selectedCard: selectedCard ?? this.selectedCard,
    );
  }
}
