import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/features/onBoarding/ui/widgets/app_title_texts.dart';
import 'package:amadapp/features/onBoarding/ui/widgets/onboarding_content.dart';
import 'package:amadapp/features/onBoarding/ui/widgets/onboarding_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amadapp/features/onBoarding/logic/onboarding_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnboardingController _controller = OnboardingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/images/app_logo.png',
            height: 50.h,
            width: 50.h,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.sp, vertical: 16.sp),
          child: Column(
            children: [
              AppTitleTexts(),
              SizedBox(height: 10.h),
              Expanded(
                child: PageView.builder(
                  controller: _controller.pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _controller.onPageChanged(index);
                    });
                  },
                  itemCount: _controller.onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = _controller.onboardingData[index];
                    return OnboardingContent(
                      title: data['title'],
                      subtitle: data['subtitle'],
                      imagePath: data['image'],
                      isVisible: _controller.currentPage == index,
                    );
                  },
                ),
              ),
              OnboardingNavigation(
                currentPage: _controller.currentPage,
                totalPages: _controller.onboardingData.length,
                onNext: () => _controller.nextPage(context),
                onSkip: () => _controller.skipToHome(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
