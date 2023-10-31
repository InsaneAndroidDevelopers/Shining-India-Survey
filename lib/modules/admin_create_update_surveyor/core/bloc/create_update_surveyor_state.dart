part of 'create_update_surveyor_bloc.dart';

abstract class CreateUpdateSurveyorState extends Equatable {
  const CreateUpdateSurveyorState();
}

class CreateUpdateSurveyorInitial extends CreateUpdateSurveyorState {
  @override
  List<Object> get props => [];
}

class CreateUpdateSurveyorLoading extends CreateUpdateSurveyorState {
  @override
  List<Object> get props => [];
}

class CreateUpdateSurveyorError extends CreateUpdateSurveyorState {
  final String message;
  const CreateUpdateSurveyorError({required this.message});

  @override
  List<Object> get props => [];
}

class AllTeamsFetchedState extends CreateUpdateSurveyorState {
  final List<TeamModel> teams;
  const AllTeamsFetchedState({required this.teams});

  @override
  List<Object> get props => [];
}

class TeamCreatedSuccessState extends CreateUpdateSurveyorState {
  @override
  List<Object> get props => [];
}

class SurveyorAddedState extends CreateUpdateSurveyorState {
  @override
  List<Object> get props => [];
}

class SurveyorDeletedState extends CreateUpdateSurveyorState {
  @override
  List<Object> get props => [];
}
