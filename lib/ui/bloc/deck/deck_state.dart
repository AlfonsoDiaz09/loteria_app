part of 'deck_bloc.dart';

class DeckState {
  final List<CardModel> fullDeck;
  final List<CardModel> visibleDeck;
  final bool isEmpty;
  final int cardsPlayed;

  const DeckState({
    required this.fullDeck,
    required this.visibleDeck,
    required this.isEmpty,
    required this.cardsPlayed,
  });

  DeckState copyWith({
    List<CardModel>? fullDeck,
    List<CardModel>? visibleDeck,
    bool? isEmpty,
    int? cardsPlayed,
  }) {
    return DeckState(
      fullDeck: fullDeck ?? this.fullDeck,
      visibleDeck: visibleDeck ?? this.visibleDeck,
      isEmpty: isEmpty ?? this.isEmpty,
      cardsPlayed: cardsPlayed ?? this.cardsPlayed,
    );
  }

  static DeckState initial() => DeckState(
    fullDeck: [], visibleDeck: [], isEmpty: true, cardsPlayed: 0);
}