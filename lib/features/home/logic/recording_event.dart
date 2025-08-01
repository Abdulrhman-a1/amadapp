import 'package:equatable/equatable.dart';

abstract class RecordingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartRecording extends RecordingEvent {}

class StopRecording extends RecordingEvent {}

class UpdateDuration extends RecordingEvent {}
