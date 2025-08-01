import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void appBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,

    builder: (BuildContext context) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: child,
      );
    },
  );
}
