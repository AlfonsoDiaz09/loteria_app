import 'package:flutter_tts/flutter_tts.dart';

class LoteriaSpeaker {
  final FlutterTts _tts = FlutterTts();

  LoteriaSpeaker() {
    _initTts();
  }

  void _initTts() async {
    await _tts.setLanguage('es-MX');
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.4);
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}