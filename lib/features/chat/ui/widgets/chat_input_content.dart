import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:amadapp/common/widgets/custom_shapes/toast_message.dart';

class ChatInputContent extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback handleSendMessage;
  final bool isEnabled;

  const ChatInputContent({
    super.key,
    required this.controller,
    required this.handleSendMessage,
    required this.isEnabled,
  });

  @override
  State<ChatInputContent> createState() => _ChatInputContentState();
}

class _ChatInputContentState extends State<ChatInputContent> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() {}));
  }

  void _handleAlbumTap() async {
    if (!widget.isEnabled) {
      showToastMessage(
        context,
        'انتظار الرد...',
        "assets/images/question.png",
        isError: true,
      );
      return;
    }
    _pickImage(ImageSource.gallery);
  }

  void _pickImage(ImageSource source) async {
    try {
      Permission permission = source == ImageSource.camera
          ? Permission.camera
          : Permission.photos;

      var status = await permission.status;
      if (status.isDenied) {
        status = await permission.request();
      }

      if (status.isPermanentlyDenied) {
        showToastMessage(
          context,
          'يجب السماح بالوصول إلى ${source == ImageSource.camera ? 'الكاميرا' : 'الصور'}',
          "assets/images/question.png",
          isError: true,
        );
        return;
      }

      if (status.isGranted) {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(
          source: source,
          imageQuality: 80,
        );

        if (pickedFile != null) {
          setState(() {
            widget.controller.text +=
                ' [صورة تم اختيارها: ${pickedFile.name}] ';
          });
        }
      } else {
        showToastMessage(
          context,
          'تم رفض الإذن للوصول إلى ${source == ImageSource.camera ? 'الكاميرا' : 'الصور'}',
          "assets/images/question.png",
          isError: true,
        );
      }
    } catch (e) {
      showToastMessage(
        context,
        'حدث خطأ في اختيار الصورة',
        "assets/images/question.png",
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
      child: Row(
        children: [
          GestureDetector(
            onTap: _handleAlbumTap,
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Image.asset(
                'assets/images/camera.png',
                color: widget.isEnabled ? Colors.white : Colors.grey[500],
                width: 24.sp,
                height: 24.sp,
              ),
            ),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300.h),
              child: Scrollbar(
                child: SingleChildScrollView(
                  reverse: true,
                  child: TextField(
                    controller: widget.controller,
                    enabled: widget.isEnabled,
                    maxLines: null,
                    cursorColor: Colors.grey[400],
                    onTap: () {
                      if (!widget.isEnabled) {
                        showToastMessage(
                          context,
                          'انتظار الرد...',
                          "assets/images/question.png",
                          isError: true,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText: widget.isEnabled
                          ? 'اكتب رسالتك هنا'
                          : 'انتظار الرد...',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16.sp,
                        fontFamily: 'ElMessiri',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 12.h,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: widget.isEnabled ? Colors.white : Colors.grey[600],
                      fontFamily: 'IBMPlexSansArabic',
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.isEnabled && widget.controller.text.trim().isNotEmpty
                ? widget.handleSendMessage
                : null,
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Image.asset(
                'assets/images/send.png',
                color:
                    widget.isEnabled && widget.controller.text.trim().isNotEmpty
                    ? Colors.white
                    : Colors.grey[500],
                width: 24.sp,
                height: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
