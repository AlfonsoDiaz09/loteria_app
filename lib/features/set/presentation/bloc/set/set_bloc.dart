import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/core/usecase/usecase.dart';
import 'package:loteria_app/features/set/domain/entities/set_with_cards_entity.dart';
import 'package:loteria_app/features/set/domain/usecases/get_sets_with_cards.dart';
import 'package:loteria_app/main.dart';

part 'set_event.dart';
part 'set_state.dart';

class SetBloc  extends Bloc<SetEvent, SetState> {
  final GetSetsWithCards _getSetsWithCards;
  SetBloc({
    required GetSetsWithCards getSetsWithCards})
    : _getSetsWithCards = getSetsWithCards,
      super(SetInitial()) {
    on<SetEvent>((event, emit) {

    });

    on<SearchDefaultSets>((event, emit) async {
      final res = await _getSetsWithCards(NoParams());
      if (res.isLeft()) {
        logger.e(res.getLeft().toNullable()!.message);
      }
      final List<SetWithCardsEntity> sets = res.getRight().toNullable()!;
      emit(SetCargado(cardSetLocal: sets[0]));
    });
  }
}