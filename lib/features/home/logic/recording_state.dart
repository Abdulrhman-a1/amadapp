import 'package:equatable/equatable.dart';

abstract class RecordingState extends Equatable {
  const RecordingState();

  @override
  List<Object?> get props => [];
}

class RecordingInitial extends RecordingState {
  const RecordingInitial();
}

class RecordingInProgress extends RecordingState {
  final DateTime startTime;
  final Duration duration;

  const RecordingInProgress({required this.startTime, required this.duration});

  @override
  List<Object?> get props => [startTime, duration];
}
