import 'package:amadapp/features/home/logic/recording_event.dart';
import 'package:amadapp/features/home/logic/recording_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingBloc extends Bloc<RecordingEvent, RecordingState> {
  RecordingBloc() : super(const RecordingInitial()) {
    on<StartRecording>(_onStart);
    on<StopRecording>(_onStop);
    on<UpdateDuration>(_onUpdateDuration);
  }

  void _onStart(StartRecording event, Emitter<RecordingState> emit) {
    emit(
      RecordingInProgress(startTime: DateTime.now(), duration: Duration.zero),
    );
    _startTimer();
  }

  void _onStop(StopRecording event, Emitter<RecordingState> emit) {
    emit(const RecordingInitial());
  }

  void _onUpdateDuration(UpdateDuration event, Emitter<RecordingState> emit) {
    if (state is RecordingInProgress) {
      final start = (state as RecordingInProgress).startTime;
      final newDuration = DateTime.now().difference(start);
      emit(RecordingInProgress(startTime: start, duration: newDuration));
    }
  }

  void _startTimer() async {
    await Future.delayed(const Duration(seconds: 1));
    if (state is RecordingInProgress) {
      add(UpdateDuration());
      _startTimer();
    }
  }
}
