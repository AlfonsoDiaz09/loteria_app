import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/constants/api_settings.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/core/usecase/usecase.dart';
import 'package:loteria_app/data/set_cards/models/card_model.dart';
import 'package:loteria_app/data/set_cards/models/card_set_local.dart';
import 'package:loteria_app/data/set_cards/models/set_model.dart';
import 'package:loteria_app/domain/set_cards/repositories/card_api_repository.dart';
import 'package:loteria_app/domain/set_cards/repositories/set_api_repository.dart';

class ObtenerDefaultSets implements UseCase<List<CardSetLocal>, NoParams> {
  final SetApiRepository setApiRepository;
  final CardApiRepository cardApiRepository;
  final ApiSettings apiSettings;

  ObtenerDefaultSets({required this.setApiRepository, required this.cardApiRepository, required this.apiSettings});

  @override
  Future<Either<Failure, List<CardSetLocal>>> call(NoParams params) async {
    final resSet = await setApiRepository.obtenerDefaultSets();
    if (resSet.isLeft()) {
      return left(Failure(resSet.getLeft().toNullable()!.message));
    }
    final List<SetModel> sets = resSet.getRight().toNullable()!;
    final List<CardSetLocal> groupsLocals = [];
    for (var set in sets) {
      if (set.id != apiSettings.defaultSetId) continue;
      
      final resCard = await cardApiRepository.obtenerCardsBySet(set.id);
      final List<CardModel> cards = resCard.getRight().toNullable()!;
      CardSetLocal cardSetLocal = CardSetLocal(set: set, cards: cards);
      groupsLocals.add(cardSetLocal);
    }
    return right(groupsLocals);
  }
}