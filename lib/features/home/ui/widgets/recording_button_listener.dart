import 'dart:async';
import 'package:amadapp/features/home/ui/widgets/recording_circle.dart';
import 'package:amadapp/features/home/ui/widgets/recording_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amadapp/common/widgets/custom_shapes/toast_message.dart';
import 'package:amadapp/features/home/logic/voice_cubit.dart';
import 'package:amadapp/features/home/logic/voice_state.dart';

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
  Timer? _recordingTimer;
  int _recordingDuration = 0;

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

  void _startRecordingTimer() {
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration++;
      });
    });
  }

  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
    setState(() {
      _recordingDuration = 0;
    });
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VoiceCubit, VoiceState>(
      listener: (context, state) {
        if (state is VoiceRecording) {
          _pulseController.repeat(reverse: true);
          _waveController.repeat();
          _startRecordingTimer();
        } else if (state is VoiceIdle || state is VoiceSuccess) {
          _pulseController.stop();
          _waveController.stop();
          _stopRecordingTimer();
        } else if (state is VoiceError) {
          _pulseController.stop();
          _waveController.stop();
          _stopRecordingTimer();
          showToastMessage(
            context,
            state.message,
            "assets/images/question.png",
            isError: true,
          );
        } else if (state is VoiceSilent) {
          _pulseController.stop();
          _waveController.stop();
          _stopRecordingTimer();
          showToastMessage(
            context,
            state.message,
            "assets/images/question.png",
            isError: false,
          );
        }
      },
      child: Expanded(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 120.0.h),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  RecordingCircle(
                    pulseAnimation: _pulseAnimation,
                    waveAnimation: _waveAnimation,
                  ),
                  SizedBox(height: 60.h),
                  RecordingStatus(
                    duration: _recordingDuration,
                    formatter: _formatDuration,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
