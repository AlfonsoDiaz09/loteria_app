import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/features/card/domain/entities/card_entity.dart';

abstract class CardRepository {
  Future<Either<Failure, List<CardEntity>>> getCardsBySet(String setId);

  Future<Either<Failure, Unit>> createCards(List<CardEntity> cards);

  Future<Either<Failure, Unit>> updateCard(CardEntity card);
}