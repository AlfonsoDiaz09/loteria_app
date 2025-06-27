part of 'deck_bloc.dart';

@immutable
sealed class DeckEvent {}

class InitializeDeck extends DeckEvent {
  final List<CardModel> cards;

  InitializeDeck({required this.cards});
}

class PlayTopCard extends DeckEvent {}