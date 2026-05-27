class AnimatedOutController {
  late void Function() _animateOut;

  void attach(void Function() callback) {
    _animateOut = callback;
  }

  void animateCardOut() {
    _animateOut();
  }
}