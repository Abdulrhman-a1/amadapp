import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/features/chat/ui/widgets/message_container.dart';
import 'package:amadapp/features/chat/ui/widgets/message_content.dart';
import 'package:amadapp/common/widgets/custom_shapes/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagePaste extends StatefulWidget {
  const MessagePaste({super.key});

  @override
  State<MessagePaste> createState() => MessagePasteState();
}

class MessagePasteState extends State<MessagePaste> {
  final TextEditingController textController = TextEditingController();
  String pastedContent = '';

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> pasteContent() async {
    try {
      ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data != null && data.text != null) {
        if (data.text!.length > 300) {
          showMaxLengthMessage();
          return;
        }

        setState(() {
          pastedContent = data.text!;
          textController.text = data.text!;
        });
        showSuccessMessage();
      } else {
        showNoContentMessage();
      }
    } catch (e) {
      showErrorMessage();
    }
  }

  void showSuccessMessage() {
    showToastMessage(
      context,
      "تم لصق المحتوى بنجاح",
      "assets/images/add-post.png",
      isError: false,
    );
  }

  void showNoContentMessage() {
    showToastMessage(
      context,
      "لا يوجد محتوى في الحافظة",
      "assets/images/question.png",
      isError: true,
    );
  }

  void showErrorMessage() {
    showToastMessage(
      context,
      'خطأ أثناء اللصق',
      "assets/images/question.png",
      isError: true,
    );
  }

  void showMaxLengthMessage() {
    showToastMessage(
      context,
      'لا يمكنك إرسال أكثر من 300 حرف',
      "assets/images/question.png",
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/community.png',
                  width: 32.w,
                  height: 32.h,
                ),
                SizedBox(width: 4.w),
                Text(
                  'لا تكون عرضة للاحتيال',
                  style: TextStyle(
                    color: AppColors.mainTextWhite,
                    fontSize: 18.sp,
                    fontFamily: 'ElMessiri',
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Text(
              'الصق محتوى الرسالة هنا',
              style: TextStyle(
                color: AppColors.mainPurple,
                fontSize: 18.sp,
                fontFamily: 'ElMessiri',
              ),
            ),
            SizedBox(height: 16.h),
            pastedContent.isEmpty
                ? MessageContainer(onTap: pasteContent)
                : MessageContent(
                    textController: textController,
                    onPressed: pasteContent,
                    onClear: () {
                      setState(() {
                        pastedContent = '';
                        textController.clear();
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
