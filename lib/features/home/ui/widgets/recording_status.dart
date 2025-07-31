import 'package:amadapp/common/widgets/custom_shapes/info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/features/home/logic/voice_state.dart';
import 'package:amadapp/features/home/logic/voice_cubit.dart';

class RecordingStatus extends StatelessWidget {
  final int duration;
  final String Function(int) formatter;

  const RecordingStatus({
    super.key,
    required this.duration,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceCubit, VoiceState>(
      builder: (context, state) {
        if (state is VoiceRecording) {
          return InfoContainer(
            color: AppColors.errorColor,
            text: formatter(duration),
            icon: Icons.fiber_manual_record,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          );
        } else if (state is VoiceSending) {
          return InfoContainer(
            color: AppColors.mainBlue,
            text: 'يتم انهاء التسجيل...',
            showLoader: true,
          );
        } else if (state is VoiceSuccess) {
          return InfoContainer(
            color: Colors.green,
            text: 'تم ارسال الصوت بنجاح',
            icon: Icons.check_circle,
          );
        } else {
          return InfoContainer(
            color: AppColors.mainBlue,
            text: 'اضغط مطولاً للتسجيل',
          );
        }
      },
    );
  }
}
