import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/common/widgets/custom_shapes/rounded_card.dart';
import 'package:amadapp/features/onBoarding/ui/widgets/scam_examples.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnboardingContent extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isVisible;
  final Widget? customWidget;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.isVisible = false,
    this.customWidget,
  });

  @override
  State<OnboardingContent> createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<OnboardingContent>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _textController;
  late Animation<double> _imageAnimation;
  late Animation<double> _textAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _imageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _textController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.elasticOut),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    if (widget.isVisible) {
      _startAnimations();
    }
  }

  void _startAnimations() {
    _imageController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _textController.forward();
    });
  }

  @override
  void didUpdateWidget(OnboardingContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _imageController.reset();
      _textController.reset();
      _startAnimations();
    }
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Widget showImage() {
    if (widget.imagePath.isEmpty) {
      return ScamExamples();
    } else if (widget.imagePath.endsWith('.json')) {
      return Lottie.asset(
        widget.imagePath,
        height: 120.h,
        width: 120.w,
        controller: _imageController,
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        if (widget.imagePath.isNotEmpty) ...[
          if (widget.imagePath.endsWith('.json')) ...[
            ScaleTransition(
              scale: _imageAnimation,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.mainBlue.withOpacity(0.2),
                      AppColors.mainBabyBlue.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.sp),
                  child: showImage(),
                ),
              ),
            ),
          ] else ...[
            ScaleTransition(scale: _imageAnimation, child: showImage()),
          ],
        ] else ...[
          ScaleTransition(scale: _imageAnimation, child: showImage()),
        ],
        SizedBox(height: widget.imagePath.isNotEmpty ? 30.h : 60.h),
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _textAnimation,
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainTextWhite,
                    fontFamily: 'ElMessiri',
                    shadows: [
                      Shadow(
                        color: AppColors.mainBlue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                RoundedCard(widget: widget),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
