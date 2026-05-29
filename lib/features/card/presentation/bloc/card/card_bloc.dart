
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/features/card/domain/entities/card_entity.dart';
import 'package:loteria_app/features/card/domain/usecases/get_cards_by_set.dart';
import 'package:loteria_app/main.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc  extends Bloc<CardEvent, CardState> {
  final GetCardsBySet _getCardsBySet;
  CardBloc({
    required GetCardsBySet getCardsBySet})
    : _getCardsBySet = getCardsBySet,
      super(CardInitial()) {
    on<CardEvent>((event, emit) {

    });

    on<SearchCards>((event, emit) async {
      final res = await _getCardsBySet(event.setId);
      if (res.isLeft()) {
        logger.e(res.getLeft().toNullable()!.message);
      }
      final List<CardEntity> cards = res.getRight().toNullable()!;
      logger.i("Cards obtenidos: ${cards[0].name}");
    });
  }
}