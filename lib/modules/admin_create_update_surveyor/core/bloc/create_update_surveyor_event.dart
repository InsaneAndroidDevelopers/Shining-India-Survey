part of 'create_update_surveyor_bloc.dart';

abstract class CreateUpdateSurveyorEvent extends Equatable {
  const CreateUpdateSurveyorEvent();
}

class GetAllTeamsData extends CreateUpdateSurveyorEvent {
  @override
  List<Object?> get props => [];
}

class CreateTeam extends CreateUpdateSurveyorEvent {
  final String teamName;
  const CreateTeam({required this.teamName});

  @override
  List<Object?> get props => [];
}

class RemoveSurveyor extends CreateUpdateSurveyorEvent {
  @override
  List<Object?> get props => [];
}

class CreateSurveyor extends CreateUpdateSurveyorEvent {
  @override
  List<Object?> get props => [];
}

class UpdateSurveyor extends CreateUpdateSurveyorEvent {
  @override
  List<Object?> get props => [];
}