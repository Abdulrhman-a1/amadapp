import 'package:amadapp/common/theming/app_colors.dart';
import 'package:amadapp/common/widgets/custom_shapes/floating_point.dart';
import 'package:amadapp/features/home/logic/recording_bloc.dart';
import 'package:amadapp/features/home/logic/recording_event.dart';
import 'package:amadapp/features/home/logic/recording_state.dart';
import 'package:amadapp/features/home/logic/speech_controller.dart';
import 'package:amadapp/features/home/ui/widgets/recording_button.dart';
import 'package:amadapp/features/home/ui/widgets/recording_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecordingBloc _recordingBloc = RecordingBloc();
  final SpeechController _speechController = SpeechController();

  @override
  void initState() {
    super.initState();
    _speechController.initializeSpeech();
  }

  @override
  void dispose() {
    _recordingBloc.close();
    _speechController.dispose();
    super.dispose();
  }

  void _handleRecordingToggle() {
    if (_recordingBloc.state is RecordingInProgress) {
      _recordingBloc.add(StopRecording());
      _speechController.stopListening();
    } else {
      _recordingBloc.add(StartRecording());
      _speechController.startListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingBloc, RecordingState>(
      bloc: _recordingBloc,
      builder: (context, state) {
        final isRecording = state is RecordingInProgress;

        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 0,
            title: Text(
              'نــَـبِــه',
              style: TextStyle(
                color: AppColors.mainTextWhite,
                fontFamily: 'ElMessiri',
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Image.asset("assets/images/figures.png"),
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/Background.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RecordingButton(
                        isRecording: isRecording,
                        isStarting: _speechController.isStarting,
                        onRecordingChanged: _handleRecordingToggle,
                      ),
                      SizedBox(height: 24.h),
                      RecordingStatus(
                        isRecording: isRecording,
                        isStarting: _speechController.isStarting,
                        onTap: _handleRecordingToggle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: const FloatingPoint(),
        );
      },
    );
  }
}
