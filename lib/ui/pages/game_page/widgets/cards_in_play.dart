import 'package:flutter/material.dart';
import 'package:loteria_app/data/set_cards/models/card_model.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/card_loteria.dart';

class CardsInPlay extends StatelessWidget {
  final List<CardModel> cards;
  final VoidCallback onCardPlayed;

  const CardsInPlay({
    super.key,
    required this.cards,
    required this.onCardPlayed,
  });

  Widget _buildCard(CardModel card, {bool isDragging = false}) {
    return CardLoteria(isSmallCard: false, imageUrl: card.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        for (int i = cards.length - 1; i >= 0; i--)
            Positioned(
              top: i * 1,
              child: i == 0
                ? Draggable<CardModel>(
                    data: cards[i],
                    feedback: _buildCard(cards[i], isDragging: true),
                    childWhenDragging: Opacity(
                      opacity: 0,
                      child: _buildCard(cards[i]),
                    ),
                    onDragEnd: (_) => onCardPlayed(),
                    child: _buildCard(cards[i]))
                : _buildCard(cards[i]),
            )
      ],
    );
  }
}