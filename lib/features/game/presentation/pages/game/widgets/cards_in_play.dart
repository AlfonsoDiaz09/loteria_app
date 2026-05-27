import 'package:flutter/material.dart';
import 'package:loteria_app/data/set_cards/models/card_model.dart';
import 'package:loteria_app/shared/controllers/animated_out_controller.dart';
import 'package:loteria_app/shared/utils/dimention_size.dart';
import 'package:loteria_app/core/services/loteria_speaker.dart';

import 'card_loteria.dart';

class CardsInPlay extends StatefulWidget {
  final List<CardModel> cards;
  final VoidCallback onCardPlayed;
  final AnimatedOutController controller;
  final VoidCallback onAnimationFinished;
  final bool hasCoverCard;

  const CardsInPlay({
    super.key,
    required this.cards,
    required this.onCardPlayed,
    required this.controller,
    required this.onAnimationFinished,
    required this.hasCoverCard,
  });

  @override
  State<CardsInPlay> createState() => _CardsInPlayState();
}

class _CardsInPlayState extends State<CardsInPlay> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isAnimating = false;
  final speaker = LoteriaSpeaker();

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

  Widget _buildCoverCard(bool isCover) {
    return CardLoteria(isSmallCard: false, isCoverCard: isCover);
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
        Center(
          child: Image.asset(
            'assets/img/trophy.png',
            width: DimentionSize.width(300),
            fit: BoxFit.cover,
          )),
        for (int i = widget.cards.length - 1; i >= 0; i--)
          Positioned(
            top: i * 1,
            child: i == 0 && !widget.hasCoverCard
              ? SlideTransition(
                position: _slideAnimation,
                child: Draggable<CardModel>(
                    data: widget.cards[i],
                    feedback: _buildCard(widget.cards[i], isDragging: true),
                    childWhenDragging: Opacity(
                      opacity: 0,
                      child: _buildCard(widget.cards[i]),
                    ),
                    onDragStarted: widget.cards.length == 1
                      ? () {}
                      : () {
                          speaker.speak(widget.cards[i+1].name);
                        },
                    onDragEnd: (_) => widget.onCardPlayed(),
                    child: _buildCard(widget.cards[i])
                  ),
              )
              : _buildCard(widget.cards[i]),
          ),
        if (widget.hasCoverCard)
          Positioned(
            top: -1,
            child: SlideTransition(
              position: _slideAnimation,
              child: Draggable<CardModel>(
                  feedback: _buildCoverCard(true),
                  childWhenDragging: Opacity(
                    opacity: 0,
                    child: _buildCoverCard(true),
                  ),
                  onDragStarted: () {
                    speaker.speak(widget.cards[0].name);
                  },
                  onDragEnd: (_) => widget.onCardPlayed(),
                  child: _buildCoverCard(true)
                ),
            )
          ),
      ],
    );
  }
}