import 'package:amadapp/common/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadContainer extends StatefulWidget {
  final VoidCallback onFilePick;

  const UploadContainer({super.key, required this.onFilePick});

  @override
  State<UploadContainer> createState() => _UploadContainerState();
}

class _UploadContainerState extends State<UploadContainer> {
  bool isDragOver = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAccept: (data) {
        setState(() => isDragOver = true);
        return true;
      },
      onAccept: (data) {
        setState(() => isDragOver = false);
        widget.onFilePick();
      },
      onLeave: (_) => setState(() => isDragOver = false),
      builder: (context, _, __) {
        return InkWell(
          onTap: widget.onFilePick,
          borderRadius: BorderRadius.circular(16.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              color: isDragOver
                  ? AppColors.mainBlue.withOpacity(0.2)
                  : AppColors.secondaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isDragOver
                    ? AppColors.mainBlue
                    : AppColors.mainBlue.withOpacity(0.3),
                width: isDragOver ? 3 : 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isDragOver ? Icons.cloud_upload : Icons.upload_file,
                  color: AppColors.mainBlue,
                  size: 48.sp,
                ),
                SizedBox(height: 16.h),
                Text(
                  isDragOver ? 'أفلت الملف هنا' : 'اسحب الملف هنا',
                  style: TextStyle(
                    color: AppColors.mainTextWhite,
                    fontSize: 16.sp,
                    fontFamily: 'IBMPlexSansArabic',
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'أو اضغط لاختيار ملف صوتي',
                  style: TextStyle(
                    color: AppColors.mainTextGrey,
                    fontSize: 14.sp,
                    fontFamily: 'IBMPlexSansArabic',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
