import 'package:loteria_app/core/constants/database_constants.dart';
import 'package:loteria_app/core/database/db_isolate.dart';
import 'package:loteria_app/features/card/data/models/card_model.dart';
import 'package:loteria_app/features/set/domain/datasources/set_local_datasource.dart';
import 'package:loteria_app/main.dart';

class SetLocalDatasourceImpl implements SetLocalDatasource {
  @override
  Future<List<CardModel>> getCardsBySet(String setId) async {
    try {
      var db = await DbIsolate.localDatabase;

      List<Map<String, Object?>> cards = await db.rawQuery('''
        SELECT * FROM ${DatabaseConstants.cardsTable}
        WHERE set_id = ?
      ''', [setId]);

      return cards.map((map) => CardModel.fromJson(map)).toList();
    } catch (e) {
      throw 'Error al obtener las cards por sets';
    }
  }

  @override
  Future<void> insertCards(List<CardModel> cards) async {
    try {
      var db = await DbIsolate.localDatabase;

      final batch = db.batch();

      for (var card in cards) {
        var cardJson = card.toJson();
        batch.insert(DatabaseConstants.cardsTable, cardJson);
      }
      await batch.commit();
      logger.d('Lote de cards guardadas correctamente: ${cards.length}');
    } catch (e, stack) {
      logger.e('Error al guardar las cards: $e', error: e, stackTrace: stack);
    }
  }
}