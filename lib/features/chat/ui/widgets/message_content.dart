import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/common/widgets/buttons/next_button.dart';
import 'package:amadapp/features/chat/ui/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageContent extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onPressed;
  final VoidCallback onClear;

  const MessageContent({
    super.key,
    required this.textController,
    required this.onPressed,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.borderColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: textController,
                maxLength: 100,
                maxLines: 3,
                readOnly: true,
                cursorColor: AppColors.mainTextWhite,
                style: TextStyle(
                  color: AppColors.mainTextWhite,
                  fontSize: 14.sp,
                  fontFamily: 'IBMPlexSansArabic',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16.sp),
                  hintText: 'سيظهر المحتوى المُلصق هنا...',
                  hintStyle: TextStyle(
                    color: AppColors.mainTextGrey,
                    fontSize: 14.sp,
                    fontFamily: 'IBMPlexSansArabic',
                  ),
                  border: InputBorder.none,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: onClear,
                  icon: Icon(Icons.close, color: AppColors.errorColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        NextButton(
          onNext: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Chat(initialMessage: textController.text),
            );
          },
          isLastPage: true,
          text: 'إرسال',
        ),
      ],
    );
  }
}
