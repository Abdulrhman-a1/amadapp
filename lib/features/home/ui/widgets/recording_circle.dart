import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordingCircle extends StatelessWidget {
  final Animation<double> pulseAnimation;
  final Animation<double> waveAnimation;
  final bool isRecording;

  const RecordingCircle({
    super.key,
    required this.pulseAnimation,
    required this.waveAnimation,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size.width * 0.5;

    return AnimatedScale(
      scale: isRecording ? 1.15 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isRecording
              ? LinearGradient(
                  colors: [
                    AppColors.errorColor.withOpacity(0.8),
                    AppColors.errorColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    AppColors.buttonColor,
                    AppColors.buttonColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          boxShadow: [
            BoxShadow(
              color: isRecording
                  ? colorScheme.error.withOpacity(0.3)
                  : Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: isRecording ? AppColors.errorColor : AppColors.borderColor,
            width: 3,
          ),
        ),
        child: Center(
          child: isRecording
              ? Icon(Icons.mic, size: size * 0.3, color: Colors.white)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mic,
                      size: 40.sp,
                      color: AppColors.mainTextWhite,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'إبدا',
                      style: TextStyle(
                        fontSize: 21.sp,
                        color: AppColors.mainTextWhite,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
