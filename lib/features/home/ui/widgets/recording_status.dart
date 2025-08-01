import 'package:amadapp/common/widgets/custom_shapes/info_container.dart';
import 'package:amadapp/features/home/logic/recording_controller.dart';
import 'package:amadapp/features/home/logic/recording_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amadapp/common/theming/app_colors.dart';

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
    return BlocBuilder<RecordingBloc, RecordingState>(
      builder: (context, state) {
        if (state is RecordingInProgress) {
          return InfoContainer(
            color: AppColors.errorColor,
            text: formatter(duration),
            icon: Icons.fiber_manual_record,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
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
