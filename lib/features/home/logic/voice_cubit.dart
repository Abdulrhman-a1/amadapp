import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amadapp/features/home/logic/voice_state.dart';
import 'package:amadapp/features/home/data/services/voice_service.dart';

class VoiceCubit extends Cubit<VoiceState> {
  final VoiceService _voiceService;

  VoiceCubit(this._voiceService) : super(const VoiceIdle());

  Future<void> startRecording() async {
    try {
      emit(const VoiceRecording());
      await _voiceService.startRecording();
    } catch (e) {
      emit(VoiceError(e.toString()));
    }
  }

  Future<void> stopRecording() async {
    try {
      final filePath = await _voiceService.stopRecording();
      if (filePath != null) {
        emit(const VoiceSending());
        await _voiceService.uploadVoiceFile(filePath);
        emit(const VoiceSuccess());
      } else {
        emit(const VoiceSilent('لم يتم التقاط أي صوت.'));
      }
    } catch (e) {
      emit(VoiceError(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _voiceService.dispose();
    return super.close();
  }
}
