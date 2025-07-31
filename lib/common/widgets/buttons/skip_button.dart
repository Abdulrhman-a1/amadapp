import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onSkip;

  const SkipButton({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSkip,
      child: Text(
        'تخطي',
        style: TextStyle(
          color: AppColors.mainTextGrey,
          fontSize: 16.sp,
          fontFamily: 'IBMPlexSansArabic',
        ),
      ),
    );
  }
}
