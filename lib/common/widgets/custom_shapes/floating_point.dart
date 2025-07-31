import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/common/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:amadapp/common/widgets/bottom_sheet/options_bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingPoint extends StatelessWidget {
  const FloatingPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 32.sp, bottom: 16.sp),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () => appBottomSheet(context, OptionsBottomSheetContent()),
          backgroundColor: AppColors.secondaryColor,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: AppColors.mainTextWhite, size: 24.sp),
        ),
      ),
    );
  }
}
