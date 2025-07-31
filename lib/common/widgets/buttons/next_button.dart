import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onNext;
  final bool isLastPage;
  final String? text;
  const NextButton({
    super.key,
    required this.onNext,
    required this.isLastPage,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainBlue.withOpacity(0.3),
            blurRadius: 44,
            spreadRadius: -10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
            side: BorderSide(color: AppColors.mainBlue, width: 1.w),
          ),
        ),
        child: Text(
          text ?? (isLastPage ? 'ابدأ' : 'التالي'),
          style: TextStyle(
            color: AppColors.mainTextWhite,
            fontSize: 16.sp,
            fontFamily: 'IBMPlexSansArabic',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
