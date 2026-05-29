import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/features/card/domain/entities/card_entity.dart';
import 'package:loteria_app/features/card/domain/repositories/card_repository.dart';

class GetCardsBySet {
  final CardRepository repository;

  GetCardsBySet({required this.repository});

  Future<Either<Failure, List<CardEntity>>> call(String setId) {
    return repository.getCardsBySet(setId);
  }
}