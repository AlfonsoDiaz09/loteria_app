
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/core/usecase/usecase.dart';
import 'package:loteria_app/data/set_cards/models/card_set_local.dart';
import 'package:loteria_app/domain/set_cards/usecases/obtener_default_sets.dart';
import 'package:loteria_app/main.dart';

part 'set_event.dart';
part 'set_state.dart';

class SetBloc  extends Bloc<SetEvent, SetState> {
  final ObtenerDefaultSets _obtenerDefaultSets;
  SetBloc({
    required ObtenerDefaultSets obtenerDefaultSets})
    : _obtenerDefaultSets = obtenerDefaultSets,
      super(SetInitial()) {
    on<SetEvent>((event, emit) {

    });

    on<SearchDefaultSets>((event, emit) async {
      final res = await _obtenerDefaultSets(NoParams());
      if (res.isLeft()) {
        logger.e(res.getLeft().toNullable()!.message);
      }
      final List<CardSetLocal> sets = res.getRight().toNullable()!;
      logger.i("Sets obtenidos: ${sets[0].cards[0].imageUrl}");
    });
  }
}