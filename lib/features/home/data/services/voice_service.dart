import 'dart:core';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class VoiceService {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _recordingPath;

  Future<void> startRecording() async {
    try {
      if (_isRecording) {
        throw Exception('التسجيل جارٍ بالفعل');
      }

      final tempDir = await getTemporaryDirectory();
      _recordingPath =
          '${tempDir.path}/voice_recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
          numChannels: 1,
        ),
        path: _recordingPath!,
      );

      _isRecording = true;
    } catch (e) {
      _isRecording = false;
      throw Exception('فشل في بدء التسجيل: $e');
    }
  }

  Future<String?> stopRecording() async {
    try {
      if (!_isRecording) {
        return null;
      }

      final path = await _audioRecorder.stop();
      _isRecording = false;
      _recordingPath = path;

      return path;
    } catch (e) {
      _isRecording = false;
      throw Exception('فشل في إيقاف التسجيل: $e');
    }
  }

  Future<void> uploadVoiceFile(String filePath) async {
    try {
      if (filePath.isEmpty) {
        throw Exception('مسار الملف غير صحيح');
      }

      await Future.delayed(const Duration(seconds: 2));

      final response = await _simulateApiCall(filePath);
      if (!response) {
        throw Exception('فشل في رفع الملف');
      }
    } catch (e) {
      throw Exception('خطأ في رفع الملف: $e');
    }
  }

  Future<bool> _simulateApiCall(String filePath) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get isRecording => _isRecording;

  Future<void> dispose() async {
    try {
      _isRecording = false;
      await _audioRecorder.dispose();
    } catch (e) {
      return;
    }
  }
}
