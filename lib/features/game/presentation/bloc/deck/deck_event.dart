part of 'deck_bloc.dart';

@immutable
sealed class DeckEvent {}

class ShuffleCards extends DeckEvent { }

class InitializeDeck extends DeckEvent {
  final List<CardEntity> cards;

  InitializeDeck({required this.cards});
}

class PlayTopCard extends DeckEvent {}