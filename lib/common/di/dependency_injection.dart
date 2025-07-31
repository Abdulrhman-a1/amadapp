import 'package:amadapp/features/home/data/services/voice_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerSingleton<VoiceService>(VoiceService());
}
