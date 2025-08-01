import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechController extends ChangeNotifier {
  final SpeechToText _speech = SpeechToText();

  final List<String> _chunks = [];
  final List<String> _currentChunkWords = [];

  bool _isListening = false;
  bool _isStarting = false;
  bool _initialized = false;

  Timer? _silenceTimer;

  List<String> get chunks => _chunks;
  bool get isListening => _isListening;
  bool get isStarting => _isStarting;

  Future<void> initializeSpeech() async {
    if (_initialized) return;
    _initialized = await _speech.initialize(
      onError: (e) => log('[Speech Error] ${e.errorMsg}'),
      onStatus: (status) {
        log('[Speech Status] $status');
        if (status == 'done' || status == 'notListening') {
          _finalizeCurrentChunk();
          _isListening = false;
          notifyListeners();
        }
      },
    );
  }

  void startListening() async {
    if (!_initialized || _isListening || _isStarting) return;

    _isStarting = true;
    notifyListeners();

    _chunks.clear();
    _currentChunkWords.clear();

    try {
      final started = await _speech.listen(
        localeId: 'ar-SA',
        listenMode: ListenMode.dictation,
        partialResults: true,
        onResult: _onSpeechResult,
      );

      _isListening = started == true;
    } catch (e) {
      log('[Speech Error] Failed to start listening: $e');
      _isListening = false;
    }

    _isStarting = false;
    notifyListeners();
  }

  void stopListening() {
    if (!_isListening && !_isStarting) return;

    _speech.stop();
    _isListening = false;
    _isStarting = false;

    _finalizeCurrentChunk();
    _printAllChunks();
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    final currentWords = result.recognizedWords.trim().split(RegExp(r'\s+'));
    if (currentWords.isEmpty) return;

    final lastWord = currentWords.last;

    if (_currentChunkWords.isEmpty || _currentChunkWords.last != lastWord) {
      _currentChunkWords.add(lastWord);
      log('[word] $lastWord');
      notifyListeners();
    }

    _resetSilenceTimer();
  }

  void _resetSilenceTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer(const Duration(seconds: 1), () {
      _finalizeCurrentChunk();
    });
  }

  void _finalizeCurrentChunk() {
    if (_currentChunkWords.isNotEmpty) {
      final chunk = _currentChunkWords.join(' ');
      _chunks.add(chunk);
      log('[chunk] $chunk');
      _currentChunkWords.clear();
    }
    _silenceTimer?.cancel();
  }

  void _printAllChunks() {
    final result = _chunks.join(' ');
    log('[Final Text] $result');
  }

  @override
  void dispose() {
    _speech.cancel();
    _silenceTimer?.cancel();
    super.dispose();
  }
}
