import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechController extends ChangeNotifier {
  final SpeechToText _speech = SpeechToText();
  String _recognizedText = '';
  bool _isListening = false;
  bool _initialized = false;
  Duration _recordDuration = Duration.zero;
  Timer? _timer;

  String get recognizedText => _recognizedText;
  bool get isListening => _isListening;
  Duration get recordDuration => _recordDuration;

  Future<void> initializeSpeech() async {
    if (_initialized) return;
    _initialized = await _speech.initialize(
      onError: (error) => log("Speech Error: ${error.errorMsg}"),
      onStatus: (status) => log("Speech Status: $status"),
    );
  }

  void startListening() {
    if (!_initialized) return;

    _recognizedText = '';
    _recordDuration = Duration.zero;
    _speech.listen(
      localeId: 'ar-SA',
      listenMode: ListenMode.dictation,
      onResult: _onSpeechResult,
    );
    _isListening = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _recordDuration += const Duration(seconds: 1);
      notifyListeners();
    });

    notifyListeners();
  }

  void stopListening() {
    if (_initialized) _speech.stop();
    _isListening = false;
    _timer?.cancel();
    notifyListeners();
  }

  void toggleListening() {
    _isListening ? stopListening() : startListening();
  }

  void clearRecognizedText() {
    _recognizedText = '';
    notifyListeners();
  }

  String getAndClearText() {
    final text = _recognizedText.trim();
    clearRecognizedText();
    return text;
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      _recognizedText += "${result.recognizedWords} ";
      notifyListeners();
    }
  }
}
