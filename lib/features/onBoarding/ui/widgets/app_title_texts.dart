import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTitleTexts extends StatelessWidget {
  const AppTitleTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          Text(
            'خلك نَــبِــه     ',
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextWhite,
              fontFamily: 'ElMessiri',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'لا تصير انت الضحية!',
            style: TextStyle(
              fontSize: 22.sp,
              color: AppColors.mainTextGrey,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
