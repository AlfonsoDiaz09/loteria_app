import 'package:loteria_app/features/card/data/models/card_model.dart';

abstract interface class CardLocalDatasource {
  Future<void> insertCards(List<CardModel> cards);

  Future<List<CardModel>> getCardsBySet(String setId);
}
