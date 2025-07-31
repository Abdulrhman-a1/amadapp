import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoContainer extends StatelessWidget {
  final Color color;
  final String text;
  final IconData? icon;
  final bool showLoader;
  final double fontSize;
  final FontWeight fontWeight;

  const InfoContainer({
    super.key,
    required this.color,
    required this.text,
    this.icon,
    this.showLoader = false,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          if (color == Colors.red)
            BoxShadow(
              color: Colors.red.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLoader)
            SizedBox(
              width: 16.w,
              height: 16.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            )
          else if (icon != null)
            Icon(icon, color: color, size: 16.sp),
          if (icon != null || showLoader) SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              color: AppColors.mainTextWhite,
              fontSize: fontSize.sp,
              fontFamily: 'IBMPlexSansArabic',
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
