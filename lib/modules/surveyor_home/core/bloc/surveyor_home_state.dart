part of 'surveyor_home_bloc.dart';

abstract class SurveyorHomeState extends Equatable {
  const SurveyorHomeState();
}

class SurveyorHomeInitial extends SurveyorHomeState {
  @override
  List<Object> get props => [];
}

class SurveyorHomeInfoFetchedState extends SurveyorHomeState {
  final String name;
  const SurveyorHomeInfoFetchedState({required this.name});

  @override
  List<Object?> get props => [];
}

class SurveyorHomeLoadingState extends SurveyorHomeState {
  @override
  List<Object> get props => [];
}

class SurveyorHomeErrorState extends SurveyorHomeState {
  final String message;
  const SurveyorHomeErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class  SurveyorHomeFetchedState extends SurveyorHomeState {
  final List<SurveyorHomeResponseModel> surveys;
  const SurveyorHomeFetchedState({required this.surveys});

  @override
  List<Object> get props => [];
}

class SurveyorLogoutLoadingState extends SurveyorHomeState {
  @override
  List<Object> get props => [];
}

class SurveyorLogoutSuccessState extends SurveyorHomeState {
  @override
  List<Object> get props => [];
}

class SurveyorLogoutErrorState extends SurveyorHomeState {
  final String message;
  const SurveyorLogoutErrorState({required this.message});

  @override
  List<Object> get props => [];
}