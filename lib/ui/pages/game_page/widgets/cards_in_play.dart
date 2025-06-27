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

  Widget _buildCard(CardModel card, double topOffset, {bool isDragging = false}) {
    return Positioned(
      top: topOffset,
      child: CardLoteria(isSmallCard: false, imageUrl: card.imageUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = cards.length - 1; i >= 0; i--)
            if (i == 0)
              Draggable<CardModel>(
                data: cards[i],
                feedback: _buildCard(cards[i], i * 1, isDragging: true),
                childWhenDragging: Opacity(
                  opacity: 0,
                  child: _buildCard(cards[i], i * 1),
                ),
                onDragEnd: (_) => onCardPlayed(),
                child: _buildCard(cards[i], i * 1),
              )
            else
              _buildCard(cards[i], i * 1),
        ],
      ),
    );
  }
}