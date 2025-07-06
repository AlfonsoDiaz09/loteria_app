part of 'deck_bloc.dart';

class DeckState {
  final List<CardModel> fullDeck;
  final List<CardModel> visibleDeck;
  final bool isEmpty;
  final List<CardModel> cardsPlayed;
  final bool hasCoverCard;

  const DeckState({
    required this.fullDeck,
    required this.visibleDeck,
    required this.isEmpty,
    required this.cardsPlayed,
    required this.hasCoverCard
  });

  DeckState copyWith({
    List<CardModel>? fullDeck,
    List<CardModel>? visibleDeck,
    bool? isEmpty,
    List<CardModel>? cardsPlayed,
    bool? hasCoverCard,
  }) {
    return DeckState(
      fullDeck: fullDeck ?? this.fullDeck,
      visibleDeck: visibleDeck ?? this.visibleDeck,
      isEmpty: isEmpty ?? this.isEmpty,
      cardsPlayed: cardsPlayed ?? this.cardsPlayed,
      hasCoverCard: hasCoverCard ?? this.hasCoverCard,
    );
  }

  static DeckState initial() => DeckState(
    fullDeck: [], visibleDeck: [], isEmpty: true, cardsPlayed: [], hasCoverCard: true);
}