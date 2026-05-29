import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/features/card/data/mappers/card_mapper.dart';
import 'package:loteria_app/features/card/domain/datasources/card_remote_datasource.dart';
import 'package:loteria_app/features/set/data/mappers/set_mapper.dart';
import 'package:loteria_app/features/set/domain/datasources/set_local_datasource.dart';
import 'package:loteria_app/features/set/domain/datasources/set_remote_datasource.dart';
import 'package:loteria_app/features/set/domain/entities/set_entity.dart';
import 'package:loteria_app/features/set/domain/entities/set_with_cards_entity.dart';
import 'package:loteria_app/features/set/domain/repositories/set_repository.dart';

class SetRepositoryImpl implements SetRepository {
  final SetRemoteDatasource remoteSet;
  final CardRemoteDatasource remoteCard;
  final SetLocalDatasource localSet;

  SetRepositoryImpl({
    required this.remoteSet,
    required this.remoteCard,
    required this.localSet,
  });

  @override
  Future<Either<Failure, List<SetEntity>>> getSets() async {
    try {
      final dtos = await remoteSet.getSets();

      final entities = dtos
          .toModelList()
          .toEntityList();

      return right(entities);
    } catch (e) {
      return left(Failure('Error obteniendo sets'));
    }
  }

  /// 🔥 CASO FLASHCARDS
  @override
  Future<Either<Failure, List<SetWithCardsEntity>>> getSetsWithCards() async {
    try {
      final setsDtos = await remoteSet.getDefaultSet();

      final futures = setsDtos.map((setDto) async {
        final set = setDto.toModel().toEntity();

        final cardsDtos = await remoteCard.getCardsBySet(set.id);

        final cards = cardsDtos
            .toModelList()
            .toEntityList();

        return SetWithCardsEntity(
          set: set,
          cards: cards,
        );
      }).toList();

      final result = await Future.wait(futures);

      return right(result);
    } catch (e) {
      return left(Failure('Error obteniendo sets con cards'));
    }
  }


}