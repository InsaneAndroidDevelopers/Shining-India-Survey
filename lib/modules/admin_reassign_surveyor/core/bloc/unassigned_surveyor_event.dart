part of 'unassigned_surveyor_bloc.dart';

abstract class UnassignedSurveyorEvent extends Equatable {
  const UnassignedSurveyorEvent();
}

class FetchAllUnassignedSurveyors extends UnassignedSurveyorEvent {
  @override
  List<Object?> get props => [];
}

