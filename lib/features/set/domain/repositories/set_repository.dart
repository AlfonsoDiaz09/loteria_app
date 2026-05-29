import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/features/card/domain/entities/card_entity.dart';
import 'package:loteria_app/features/set/domain/entities/set_entity.dart';
import 'package:loteria_app/features/set/domain/entities/set_with_cards_entity.dart';

abstract class SetRepository {
  Future<Either<Failure, List<SetEntity>>> getSets();

  Future<Either<Failure, List<SetWithCardsEntity>>> getSetsWithCards();
}