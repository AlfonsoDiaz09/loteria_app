import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/features/card/domain/entities/card_entity.dart';
import 'package:loteria_app/features/card/domain/repositories/card_repository.dart';

class UpdateCard {
  final CardRepository repository;

  UpdateCard({required this.repository});

  Future<Either<Failure, Unit>> call(CardEntity card) {
    return repository.updateCard(card);
  }
}