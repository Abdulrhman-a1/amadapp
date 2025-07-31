import 'package:amadapp/common/theming/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadPreview extends StatelessWidget {
  final PlatformFile selectedFile;
  final VoidCallback onRemove;

  const UploadPreview({
    super.key,
    required this.selectedFile,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.mainBlue.withOpacity(0.3),
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/add-post.png',
            width: 32.sp,
            height: 32.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedFile.name.length > 15
                      ? '${selectedFile.name.substring(0, 15)}...'
                      : selectedFile.name,
                  style: TextStyle(
                    color: AppColors.mainTextWhite,
                    fontSize: 14.sp,
                    fontFamily: 'IBMPlexSansArabic',
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${(selectedFile.size / 1024 / 1024).toStringAsFixed(2)} MB',
                  style: TextStyle(
                    color: AppColors.mainTextGrey,
                    fontSize: 12.sp,
                    fontFamily: 'IBMPlexSansArabic',
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, color: Colors.red, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
