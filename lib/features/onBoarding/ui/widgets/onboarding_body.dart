import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnboardingBody extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isFirstPage;

  const OnboardingBody({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.isFirstPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.h),
        Lottie.asset(imagePath, height: 200.h, width: 200.w),
        SizedBox(height: 40.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextWhite,
            fontFamily: 'ElMessiri',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.mainTextGrey,
              fontFamily: 'IBMPlexSansArabic',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
