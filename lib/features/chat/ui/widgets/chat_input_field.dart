import 'package:amadapp/features/chat/ui/widgets/chat_input_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amadapp/common/theming/app_colors.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback handleSendMessage;
  final bool isEnabled;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.handleSendMessage,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.mainTextBlack,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ChatInputContent(
        controller: controller,
        handleSendMessage: handleSendMessage,
        isEnabled: isEnabled,
      ),
    );
  }
}
