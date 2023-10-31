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
  final String teamId;
  final String surveyorId;
  const RemoveSurveyor({required this.teamId, required this.surveyorId});

  @override
  List<Object?> get props => [];
}

class CreateSurveyor extends CreateUpdateSurveyorEvent {
  final String name;
  final String email;
  final String password;
  final String teamId;
  const CreateSurveyor({required this.teamId, required this.email, required this.password, required this.name});

  @override
  List<Object?> get props => [];
}

class AddSurveyorIntoTeam extends CreateUpdateSurveyorEvent {
  final String teamId;
  final String surveyorId;
  const AddSurveyorIntoTeam({required this.teamId, required this.surveyorId});

  @override
  List<Object?> get props => [];
}

class UpdateSurveyor extends CreateUpdateSurveyorEvent {
  @override
  List<Object?> get props => [];
}