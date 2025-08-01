import 'package:amadapp/features/home/logic/recording_controller.dart';
import 'package:amadapp/features/home/logic/speech_to_text.dart';
import 'package:amadapp/features/home/ui/widgets/recording_button_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RecordingButton extends StatelessWidget {
  const RecordingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SpeechController()..initializeSpeech(),
        ),
        BlocProvider(create: (_) => RecordingBloc()),
      ],
      child: const RecordingButtonListener(),
    );
  }
}
