import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/features/card/data/mappers/card_mapper.dart';
import 'package:loteria_app/features/card/domain/datasources/card_local_datasource.dart';
import 'package:loteria_app/features/card/domain/datasources/card_remote_datasource.dart';
import 'package:loteria_app/features/card/domain/entities/card_entity.dart';
import 'package:loteria_app/features/card/domain/repositories/card_repository.dart';

class CardRepositoryImpl implements CardRepository{
  CardLocalDatasource localCard;
  CardRemoteDatasource remoteCard;

  CardRepositoryImpl({required this.localCard, required this.remoteCard});

  @override
  Future<Either<Failure, List<CardEntity>>> getCardsBySet(String setId) async {
    try {
      final dtos = await remoteCard.getCardsBySet(setId);

      final entities = dtos
          .toModelList()
          .toEntityList();

      return right(entities);
    } catch (e) {
      return left(Failure('Error obteniendo cards: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createCards(List<CardEntity> cards) async {
    try {
      final models = cards.toModelList();

      final request = models.map((e) => e.toJson()).toList();

      await remoteCard.createCards(request);

      return right(unit);
    } catch (e) {
      return left(Failure('Error creando cards: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCard(CardEntity card) async {
    try {
      final dto = card.toModel().toDto();

      await remoteCard.updateCard(dto);

      return right(unit);
    } catch (e) {
      return left(Failure('Error actualizando card'));
    }
  }
}