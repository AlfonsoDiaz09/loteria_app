import 'package:flutter/material.dart';

class ProgressBarController {
  late AnimationController _controller;

  void attach(AnimationController controller) {
    _controller = controller;
  }

  void start() {
    _controller.forward(from: 0);
  }

  void reset() {
    _controller.reset();
  }

  void pause() {
    _controller.stop();
  }

  void resume() {
    _controller.forward();
  }

  double get value => _controller.value;
}