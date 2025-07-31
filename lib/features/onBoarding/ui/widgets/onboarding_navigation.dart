import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/common/widgets/buttons/next_button.dart';
import 'package:amadapp/common/widgets/buttons/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingNavigation extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingNavigation({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalPages,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index
                    ? AppColors.mainBlue
                    : AppColors.mainTextGrey.withOpacity(0.3),
              ),
            ),
          ),
        ),
        SizedBox(height: 40.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkipButton(onSkip: onSkip),
            NextButton(
              onNext: onNext,
              isLastPage: currentPage == totalPages - 1,
            ),
          ],
        ),
      ],
    );
  }
}
