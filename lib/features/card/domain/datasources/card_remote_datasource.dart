import 'package:loteria_app/features/card/data/dto/card_dto.dart';

abstract interface class CardRemoteDatasource {
  Future<List<CardDto>> getCardsBySet(String setId);

  Future<void> createCards(List<Map<String, dynamic>> request);

  Future<void> updateCard(CardDto dto);
}