import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessageContainer extends StatelessWidget {
  final bool isUser;
  final String message;
  const ChatMessageContainer({
    super.key,
    required this.isUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.buttonColor
                    : AppColors.primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r),
                  bottomLeft: isUser
                      ? Radius.circular(18.r)
                      : Radius.circular(4.r),
                  bottomRight: isUser
                      ? Radius.circular(4.r)
                      : Radius.circular(18.r),
                ),
                border: Border.all(
                  color: isUser
                      ? AppColors.mainTextWhite.withOpacity(0.3)
                      : AppColors.borderColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: AppColors.mainTextWhite,
                  fontSize: 14.sp,
                  fontFamily: 'IBMPlexSansArabic',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
