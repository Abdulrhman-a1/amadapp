import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animate_do/animate_do.dart';

void showToastMessage(
  BuildContext context,
  String message,
  String iconPath, {
  bool isError = true,
}) {
  FToast fToast = FToast();
  fToast.init(context);

  final Color iconColor = isError ? Colors.red : Colors.green;
  final Color backgroundColor = AppColors.mainTextWhite;

  //animation
  Widget toast = FadeInUp(
    from: 20,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        gradient: LinearGradient(
          colors: [
            backgroundColor.withOpacity(0.9),
            backgroundColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.mainBabyBlue.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            child: Image.asset(iconPath, width: 24.w, height: 24.h),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'IBMPlexSansArabic',
              ),
            ),
          ),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap: () {
              fToast.removeCustomToast();
            },
            child: Icon(
              Icons.close,
              color: Colors.black.withOpacity(0.6),
              size: 20.w,
            ),
          ),
        ],
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 3),
  );
}
