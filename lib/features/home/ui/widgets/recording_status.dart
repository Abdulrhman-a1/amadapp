import 'package:flutter/material.dart';
import 'dart:async';
import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordingStatus extends StatefulWidget {
  final bool isRecording;
  final bool isStarting;
  final VoidCallback? onTap;

  const RecordingStatus({
    super.key,
    required this.isRecording,
    this.isStarting = false,
    this.onTap,
  });

  @override
  State<RecordingStatus> createState() => _RecordingStatusState();
}

class _RecordingStatusState extends State<RecordingStatus> {
  Timer? _timer;
  int _recordingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(RecordingStatus oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording != oldWidget.isRecording) {
      if (widget.isRecording) {
        _startTimer();
      } else {
        _stopTimer();
        _resetTimer();
      }
    }
  }

  void _startTimer() {
    if (widget.isRecording) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _recordingSeconds++;
          });
        }
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _resetTimer() {
    setState(() {
      _recordingSeconds = 0;
    });
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isRecording = widget.isRecording;
    final isStarting = widget.isStarting;
    final showRedState = isRecording;
    final showGreenState = isStarting && !isRecording;

    final text = showGreenState
        ? 'سيتم بدء التسجيل...'
        : showRedState
        ? 'التسجيل... ${_formatDuration(_recordingSeconds)}'
        : 'إبدأ التسجيل';

    final bgColor = showGreenState
        ? Colors.green.withOpacity(0.1)
        : showRedState
        ? AppColors.errorColor.withOpacity(0.1)
        : AppColors.secondaryColor.withOpacity(0.5);

    final borderColor = showGreenState
        ? Colors.green.withOpacity(0.3)
        : showRedState
        ? AppColors.errorColor.withOpacity(0.3)
        : AppColors.borderColor.withOpacity(0.3);

    final textColor = showGreenState
        ? Colors.green
        : showRedState
        ? AppColors.errorColor
        : AppColors.borderColor;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showRedState) ...[
              Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.errorColor,
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18.sp,
                fontWeight: (showRedState || showGreenState)
                    ? FontWeight.bold
                    : FontWeight.w400,
                fontFamily: 'ElMessiri',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
