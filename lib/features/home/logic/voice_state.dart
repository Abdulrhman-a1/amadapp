abstract class VoiceState {
  const VoiceState();
}

class VoiceIdle extends VoiceState {
  const VoiceIdle();
}

class VoiceRecording extends VoiceState {
  const VoiceRecording();
}

class VoiceSending extends VoiceState {
  const VoiceSending();
}

class VoiceSuccess extends VoiceState {
  const VoiceSuccess();
}

class VoiceError extends VoiceState {
  final String message;

  const VoiceError(this.message);
}

class VoiceSilent extends VoiceState {
  final String message;
  const VoiceSilent(this.message);
}
