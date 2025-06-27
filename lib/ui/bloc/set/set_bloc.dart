
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/core/usecase/usecase.dart';
import 'package:loteria_app/domain/set_cards/entities/set_entity.dart';
import 'package:loteria_app/domain/set_cards/usecases/obtener_sets.dart';
import 'package:loteria_app/main.dart';

part 'set_event.dart';
part 'set_state.dart';

class SetBloc  extends Bloc<SetEvent, SetState> {
  final ObtenerSets _obtenerSets;
  SetBloc({
    required ObtenerSets obtenerSets})
    : _obtenerSets = obtenerSets,
      super(SetInitial()) {
    on<SetEvent>((event, emit) {

    });

    on<SearchSets>((event, emit) async {
      final res = await _obtenerSets(NoParams());
      if (res.isLeft()) {
        logger.e(res.getLeft().toNullable()!.message);
      }
      final List<SetEntity> sets = res.getRight().toNullable()!;
      logger.i("Sets obtenidos: ${sets[0].description}");
    });
  }
}