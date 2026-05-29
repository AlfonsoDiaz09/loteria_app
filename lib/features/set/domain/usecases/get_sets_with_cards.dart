import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/core/usecase/usecase.dart';
import 'package:loteria_app/features/set/domain/entities/set_with_cards_entity.dart';
import 'package:loteria_app/features/set/domain/repositories/set_repository.dart';

class GetSetsWithCards implements UseCase<List<SetWithCardsEntity>, NoParams> {
  final SetRepository repository;

  GetSetsWithCards({required this.repository});

  @override
  Future<Either<Failure, List<SetWithCardsEntity>>> call(NoParams params) async {
    final resSetWithCards = await repository.getSetsWithCards();
    if (resSetWithCards.isLeft()) {
      return left(Failure(resSetWithCards.getLeft().toNullable()!.message));
    }

    final List<SetWithCardsEntity> setWithCards = resSetWithCards.getRight().toNullable()!;
    return right(setWithCards);
  }
}