import 'package:amadapp/features/home/data/services/voice_service.dart';
import 'package:amadapp/features/home/logic/voice_cubit.dart';
import 'package:amadapp/features/home/ui/widgets/recording_button_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingButton extends StatelessWidget {
  const RecordingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VoiceCubit(VoiceService()),
      child: const RecordingButtonListener(),
    );
  }
}
