import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/common/widgets/custom_shapes/floating_point.dart';
import 'package:amadapp/features/home/ui/widgets/record_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          'نــَـبِــه',
          style: TextStyle(
            color: AppColors.mainTextWhite,
            fontFamily: 'ElMessiri',
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset("assets/images/figures.png"),
            Positioned.fill(
              child: Image.asset(
                "assets/images/Background.png",
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.sp),
              child: Column(children: [RecordingButton()]),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingPoint(),
    );
  }
}
