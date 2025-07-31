import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/features/onBoarding/ui/widgets/onboarding_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard({super.key, required this.widget});

  final OnboardingContent widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.mainBlue.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        widget.subtitle,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.mainTextGrey,
          fontFamily: 'IBMPlexSansArabic',
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
