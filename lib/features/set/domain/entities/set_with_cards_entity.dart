import 'package:loteria_app/features/card/domain/entities/card_entity.dart';

import 'set_entity.dart';

class SetWithCardsEntity {
  final SetEntity set;
  final List<CardEntity> cards;

  SetWithCardsEntity({
    required this.set,
    required this.cards,
  });
}