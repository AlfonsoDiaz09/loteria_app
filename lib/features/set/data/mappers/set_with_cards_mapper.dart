import 'package:loteria_app/features/card/domain/entities/card_entity.dart';
import 'package:loteria_app/features/set/domain/entities/set_entity.dart';
import 'package:loteria_app/features/set/domain/entities/set_with_cards_entity.dart';

extension SetWithCardsMapper on List<SetEntity> {
  List<SetWithCardsEntity> attachCards(List<CardEntity> cards) {
    final Map<String, List<CardEntity>> grouped = {};

    for (final card in cards) {
      grouped.putIfAbsent(card.setId, () => []);
      grouped[card.setId]!.add(card);
    }

    return map((set) {
      return SetWithCardsEntity(
        set: set,
        cards: grouped[set.id] ?? [],
      );
    }).toList();
  }
}