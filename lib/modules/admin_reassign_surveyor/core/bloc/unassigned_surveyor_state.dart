part of 'unassigned_surveyor_bloc.dart';

abstract class UnassignedSurveyorState extends Equatable {
  const UnassignedSurveyorState();
}

class UnassignedSurveyorInitial extends UnassignedSurveyorState {
  @override
  List<Object> get props => [];
}

class UnassignedSurveyorLoading extends UnassignedSurveyorState {
  @override
  List<Object> get props => [];
}

class UnassignedSurveyorError extends UnassignedSurveyorState {
  final String message;

  const UnassignedSurveyorError({required this.message});
  @override
  List<Object> get props => [];
}

class UnassignedSurveyorsFetched extends UnassignedSurveyorState {
  final List<UnassignedSurveyorModel> list;

  const UnassignedSurveyorsFetched({required this.list});
  @override
  List<Object> get props => [];
}