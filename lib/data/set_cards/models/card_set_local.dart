import 'package:loteria_app/data/set_cards/models/card_model.dart';
import 'package:loteria_app/data/set_cards/models/set_model.dart';

class CardSetLocal {
  final SetModel set;
  final List<CardModel> cards;

  CardSetLocal({
    required this.set,
    required this.cards,
  });

  factory CardSetLocal.fromMap(
    Map<String, dynamic> setMap,
    List<Map<String, dynamic>> cardsMap) {
      return CardSetLocal(
        set: SetModel.fromJson(setMap),
        cards: cardsMap.map((map) => CardModel.fromJson(map)).toList(),
      );}

  Map<String, dynamic> setToMap() => set.toJson();
  List<Map<String, dynamic>> cardsToMap() => cards.map((c) => c.toJson()).toList();
}