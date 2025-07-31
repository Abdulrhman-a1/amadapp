import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconAndText extends StatelessWidget {
  final String imgPath;
  final String text;
  final String? description;
  final VoidCallback? onTap;
  final Color? color;
  final double? fontSize;
  final bool isContainerNeeded;
  final bool isStart;
  final double? iconSize;

  const IconAndText({
    super.key,
    required this.imgPath,
    required this.text,
    this.description,
    this.onTap,
    this.color,
    this.fontSize,
    this.isContainerNeeded = true,
    this.isStart = true,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.sp),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: isStart
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            isContainerNeeded
                ? Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(imgPath, width: 20.sp, height: 20.sp),
                  )
                : Image.asset(imgPath, width: 25.sp, height: 25.sp),

            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: color ?? AppColors.mainTextWhite,
                      fontSize: fontSize ?? 18.sp,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (description != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      description!,
                      style: TextStyle(
                        color: AppColors.mainTextGrey,
                        fontSize: 14.sp,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
