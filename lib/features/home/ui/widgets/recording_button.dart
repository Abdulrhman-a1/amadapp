import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordingButton extends StatefulWidget {
  final VoidCallback? onRecordingChanged;
  final bool isRecording;
  final bool isStarting;

  const RecordingButton({
    super.key,
    this.onRecordingChanged,
    this.isRecording = false,
    this.isStarting = false,
  });

  @override
  State<RecordingButton> createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _scaleController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant RecordingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isRecording && _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _scaleController.reverse();
    widget.onRecordingChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isRecording
        ? AppColors.errorColor
        : widget.isStarting
        ? Colors.green
        : AppColors.buttonColor;

    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) => _handleTap(),
      onTapCancel: () => _scaleController.reverse(),
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseAnimation, _scaleAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isRecording
                ? _pulseAnimation.value * _scaleAnimation.value
                : _scaleAnimation.value,
            child: Center(
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 3),
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: widget.isRecording ? 20 : 10,
                      spreadRadius: widget.isRecording ? 5 : 2,
                    ),
                  ],
                ),
                child: Icon(
                  widget.isRecording
                      ? Icons.stop
                      : widget.isStarting
                      ? Icons.hourglass_top
                      : Icons.mic_none_outlined,
                  color: AppColors.mainTextWhite,
                  size: 48.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
