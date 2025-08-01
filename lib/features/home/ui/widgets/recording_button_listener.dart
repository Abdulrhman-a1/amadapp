import 'package:amadapp/features/home/logic/recording_controller.dart';
import 'package:amadapp/features/home/logic/recording_event.dart';
import 'package:amadapp/features/home/logic/recording_state.dart';
import 'package:amadapp/features/home/logic/speech_to_text.dart';
import 'package:amadapp/features/home/ui/widgets/recording_circle.dart';
import 'package:amadapp/features/home/ui/widgets/recording_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amadapp/common/widgets/custom_shapes/toast_message.dart';

class RecordingButtonListener extends StatefulWidget {
  const RecordingButtonListener({super.key});

  @override
  State<RecordingButtonListener> createState() =>
      _RecordingButtonListenerState();
}

class _RecordingButtonListenerState extends State<RecordingButtonListener>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );
  }

  void _handleStart() {
    context.read<SpeechController>().startListening();
    context.read<RecordingBloc>().add(StartRecording());
    _pulseController.repeat(reverse: true);
    _waveController.repeat();
  }

  void _handleStop() {
    final speechController = context.read<SpeechController>();
    speechController.stopListening();
    context.read<RecordingBloc>().add(StopRecording());

    final finalText = speechController.getAndClearText();

    if (finalText.isEmpty) {
      showToastMessage(
        context,
        "لم يتم التقاط صوت",
        "assets/images/question.png",
        isError: false,
      );
    } else {
      showToastMessage(
        context,
        "النص النهائي: $finalText",
        "assets/images/conversation.png",
        isError: false,
      );
    }

    _pulseController.stop();
    _waveController.stop();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingBloc, RecordingState>(
      builder: (context, state) {
        return Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 120.0.h),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                      onLongPressStart: (_) => _handleStart(),
                      onLongPressEnd: (_) => _handleStop(),
                      child: RecordingCircle(
                        pulseAnimation: _pulseAnimation,
                        waveAnimation: _waveAnimation,
                        isRecording: state is RecordingInProgress,
                      ),
                    ),
                    SizedBox(height: 60.h),
                    RecordingStatus(
                      duration: state is RecordingInProgress
                          ? state.duration.inSeconds
                          : 0,
                      formatter: _formatDuration,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
