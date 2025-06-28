import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/data/set_cards/models/card_model.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState>{
  static const int visibleLimit = 15;

  DeckBloc() :super(DeckState.initial()) {
    on<DeckEvent>((event, emit) {

    });

    on<InitializeDeck>((event, emit) {
      final fullDeck = List<CardModel>.from(event.cards);
      final visible = fullDeck.length <= visibleLimit
          ? List<CardModel>.from(fullDeck)
          : fullDeck.sublist(fullDeck.length - visibleLimit);

      emit(
        state.copyWith(
        fullDeck: fullDeck,
        visibleDeck: visible,
        isEmpty: visible.isEmpty));
    });

    on<PlayTopCard>((event, emit) {
      final current = List<CardModel>.from(state.visibleDeck);
      final full = state.fullDeck;
      final played = state.cardsPlayed;

      played.add(current[0]);

      if (current.isEmpty || played.length >= full.length) return;

      current.removeAt(0);

      final nextIndex = played.length + visibleLimit;

      if (nextIndex < full.length) {
        current.add(full[nextIndex]);
      }

      emit(
        state.copyWith(
        visibleDeck: current,
        isEmpty: current.isEmpty,
        cardsPlayed: played));
    });
  }
}