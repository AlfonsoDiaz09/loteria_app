import 'package:flutter/material.dart';
import 'package:loteria_app/data/set_cards/models/card_model.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/card_loteria.dart';
import 'package:loteria_app/ui/utils/animated_out_controller.dart';

class CardsInPlay extends StatefulWidget {
  final List<CardModel> cards;
  final VoidCallback onCardPlayed;
  final AnimatedOutController controller;
  final VoidCallback onAnimationFinished;

  const CardsInPlay({
    super.key,
    required this.cards,
    required this.onCardPlayed,
    required this.controller,
    required this.onAnimationFinished
  });

  @override
  State<CardsInPlay> createState() => _CardsInPlayState();
}

class _CardsInPlayState extends State<CardsInPlay> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(2.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    widget.controller.attach(() {
      if (_isAnimating || _animationController.isAnimating) return;

      setState(() => _isAnimating = true);

      _animationController.forward().then((_) {
        widget.onCardPlayed();
        _animationController.reset();
        setState(() => _isAnimating = false);
        widget.onAnimationFinished(); 
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildCard(CardModel card, {bool isDragging = false}) {
    return CardLoteria(isSmallCard: false, imageUrl: card.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        for (int i = widget.cards.length - 1; i >= 0; i--)
            Positioned(
              top: i * 1,
              child: i == 0
                ? SlideTransition(
                  position: _slideAnimation,
                  child: Draggable<CardModel>(
                      data: widget.cards[i],
                      feedback: _buildCard(widget.cards[i], isDragging: true),
                      childWhenDragging: Opacity(
                        opacity: 0,
                        child: _buildCard(widget.cards[i]),
                      ),
                      onDragEnd: (_) => widget.onCardPlayed(),
                      child: _buildCard(widget.cards[i])
                    ),
                )
                : _buildCard(widget.cards[i]),
            )
      ],
    );
  }
}