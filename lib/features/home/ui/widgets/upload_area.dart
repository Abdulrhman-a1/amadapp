import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/common/widgets/buttons/next_button.dart';
import 'package:amadapp/common/widgets/custom_shapes/toast_message.dart';
import 'package:amadapp/common/widgets/custom_shapes/upload_container.dart';
import 'package:amadapp/common/widgets/custom_shapes/upload_preview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadArea extends StatefulWidget {
  const UploadArea({super.key});

  @override
  State<UploadArea> createState() => _UploadAreaState();
}

class _UploadAreaState extends State<UploadArea> {
  PlatformFile? selectedFile;

  Future<void> pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a'],
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          selectedFile = result.files.first;
        });

        showToastMessage(
          context,
          'تم اختيار الملف بنجاح',
          "assets/images/add-post.png",
          isError: false,
        );
      }
    } catch (e) {
      showToastMessage(
        context,
        'حدث خطأ أثناء اختيار الملف',
        "assets/images/question.png",
        isError: true,
      );
    }
  }

  void _removeFile() {
    setState(() {
      selectedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/community.png',
              width: 32.sp,
              height: 32.sp,
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
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'اسحب الملف هنا',
            style: TextStyle(
              color: AppColors.mainPurple,
              fontSize: 18.sp,
              fontFamily: 'ElMessiri',
            ),
          ),
        ),
        SizedBox(height: 24.h),
        selectedFile == null
            ? UploadContainer(onFilePick: pickAudioFile)
            : UploadPreview(onRemove: _removeFile, selectedFile: selectedFile!),
        if (selectedFile != null) ...[
          SizedBox(height: 24.h),
          NextButton(
            onNext: () {
              if (selectedFile == null) {
                showToastMessage(
                  context,
                  'يجب عليك اختيار ملف صوتي',
                  "assets/images/question.png",
                  isError: true,
                );
              } else {}
            },
            isLastPage: true,
            text: 'رفع الملف',
          ),
        ],
      ],
    );
  }
}
