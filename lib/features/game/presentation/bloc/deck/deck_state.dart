part of 'deck_bloc.dart';

class DeckState {
  final List<CardEntity> fullDeck;
  final List<CardEntity> visibleDeck;
  final bool isEmpty;
  final List<CardEntity> cardsPlayed;
  final bool hasCoverCard;
  final int remainingCards;

  const DeckState({
    required this.fullDeck,
    required this.visibleDeck,
    required this.isEmpty,
    required this.cardsPlayed,
    required this.hasCoverCard,
    required this.remainingCards,
  });

  DeckState copyWith({
    List<CardEntity>? fullDeck,
    List<CardEntity>? visibleDeck,
    bool? isEmpty,
    List<CardEntity>? cardsPlayed,
    bool? hasCoverCard,
    int? remainingCards,
  }) {
    return DeckState(
      fullDeck: fullDeck ?? this.fullDeck,
      visibleDeck: visibleDeck ?? this.visibleDeck,
      isEmpty: isEmpty ?? this.isEmpty,
      cardsPlayed: cardsPlayed ?? this.cardsPlayed,
      hasCoverCard: hasCoverCard ?? this.hasCoverCard,
      remainingCards: remainingCards ?? this.remainingCards,
    );
  }

  static DeckState initial() => DeckState(
    fullDeck: [], visibleDeck: [], isEmpty: true, cardsPlayed: [], hasCoverCard: true, remainingCards: 0);
}