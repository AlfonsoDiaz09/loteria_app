
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/data/set_cards/models/card_model.dart';
import 'package:loteria_app/domain/set_cards/usecases/obtener_cards.dart';
import 'package:loteria_app/main.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc  extends Bloc<CardEvent, CardState> {
  final ObtenerCards _obtenerCards;
  CardBloc({
    required ObtenerCards obtenerCards})
    : _obtenerCards = obtenerCards,
      super(CardInitial()) {
    on<CardEvent>((event, emit) {

    });

    on<SearchCards>((event, emit) async {
      final res = await _obtenerCards(event.setId);
      if (res.isLeft()) {
        logger.e(res.getLeft().toNullable()!.message);
      }
      final List<CardModel> cards = res.getRight().toNullable()!;
      logger.i("Cards obtenidos: ${cards[0].name}");
    });
  }
}