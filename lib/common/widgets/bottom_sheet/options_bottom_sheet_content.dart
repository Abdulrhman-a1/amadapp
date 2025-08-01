import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/common/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:amadapp/common/widgets/custom_shapes/icon_and_text.dart';
import 'package:amadapp/features/chat/ui/widgets/message_paste.dart';
import 'package:amadapp/common/widgets/custom_shapes/upload_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionsBottomSheetContent extends StatelessWidget {
  const OptionsBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 12.h),
          width: 40.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: AppColors.mainTextGrey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(height: 35.h),
        Padding(
          padding: EdgeInsets.only(right: 8.0.sp),
          child: IconAndText(
            text: "خلك نبيه",
            imgPath: 'assets/images/awareness.png',
            isContainerNeeded: false,
            color: AppColors.mainPurple,
            fontSize: 22.sp,
            isStart: false,
          ),
        ),
        SizedBox(height: 30.h),
        IconAndText(
          onTap: () {
            appBottomSheet(
              context,
              Padding(padding: EdgeInsets.all(24.sp), child: UploadArea()),
            );
          },
          imgPath: 'assets/images/radio.png',
          text: 'رفع تسجيل صوتي',
          description:
              'إذا كان هناك اشتباه في احتيال عبر تسجيل صوتي، يُرجى إرفاق الملف الصوتي',
        ),
        SizedBox(height: 40.h),
        IconAndText(
          onTap: () {
            appBottomSheet(context, MessagePaste());
          },
          imgPath: 'assets/images/conversation.png',
          text: 'لصق رسالة نصية',
          description: 'الصق الرسالة النصية المشتبه بها من المحادثة',
        ),
      ],
    );
  }
}
