import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/features/card/domain/entities/card_entity.dart';
import 'package:loteria_app/features/set/presentation/bloc/set/set_bloc.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState>{
  final SetBloc _setBloc;
  static const int visibleLimit = 15;

  DeckBloc({
    required SetBloc setBloc}) 
    : _setBloc = setBloc,
      super(DeckState.initial()) {
    on<DeckEvent>((event, emit) {

    });

    on<ShuffleCards>((event, emit) async {
      final stateSetBloc = _setBloc.state;
      if (stateSetBloc is! SetCargado) return;

      final cardsShuffled = List<CardEntity>.from(stateSetBloc.cardSetLocal.cards);

      emit(
        DeckState(
          fullDeck: cardsShuffled,
          visibleDeck: [],
          isEmpty: true,
          cardsPlayed: [],
          hasCoverCard: true,
          remainingCards: 0));
    });

    on<InitializeDeck>((event, emit) {
      final fullDeck = List<CardEntity>.from(event.cards);
      final visible = fullDeck.length <= visibleLimit
          ? List<CardEntity>.from(fullDeck)
          : fullDeck.sublist(0, visibleLimit);
      final numerCards = state.cardsPlayed.isEmpty
          ? fullDeck.length
          : state.remainingCards;

      emit(
        state.copyWith(
        fullDeck: fullDeck,
        visibleDeck: visible,
        isEmpty: visible.isEmpty,
        remainingCards: numerCards));
    });

    on<PlayTopCard>((event, emit) {
      final remainingCards = state.remainingCards - 1;
      if (state.hasCoverCard) {
        emit(state.copyWith(
            hasCoverCard: false,
            remainingCards: remainingCards));
        return;
      }
      final current = List<CardEntity>.from(state.visibleDeck);
      final full = state.fullDeck;
      final played = state.cardsPlayed;

      played.add(current[0]);
      current.removeAt(0);

      final nextIndex = played.length + visibleLimit - 1;

      if (nextIndex < full.length) {
        current.add(full[nextIndex]);
      }

      emit(
        state.copyWith(
        visibleDeck: current,
        isEmpty: current.isEmpty,
        cardsPlayed: played,
        remainingCards: remainingCards));
    });
  }
}