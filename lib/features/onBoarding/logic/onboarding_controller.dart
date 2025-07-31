import 'package:amadapp/common/helpers/extensions.dart';
import 'package:amadapp/common/routing/routes.dart';
import 'package:flutter/material.dart';

class OnboardingController {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List onboardingData = [
    {
      'title': 'لا تخسر فلوسك',
      'subtitle':
          'يتلقى أكثر من 60٪ من البالغين مكالمات احتيال كل شهر. يستخدم المحتالون تقنيات متطورة لخداع الناس لمشاركة معلومات حساسة أو إجراء مدفوعات.',
      'image': 'assets/lottie/Money Bag.json',
    },
    {
      'title': 'الاحتيال في تزايد',
      'subtitle': 'في لحظة واحدة... ممكن تفقد كل شي! ',
      'image': '',
    },
  ];

  void dispose() {
    pageController.dispose();
  }

  void nextPage(BuildContext context) {
    if (currentPage < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pushReplacementNamed(Routes.homeScreen);
    }
  }

  void skipToHome(BuildContext context) {
    context.pushReplacementNamed(Routes.homeScreen);
  }

  void onPageChanged(int index) {
    currentPage = index;
  }
}
