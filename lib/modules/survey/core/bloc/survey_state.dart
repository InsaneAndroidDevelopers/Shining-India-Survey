part of 'survey_bloc.dart';

@immutable
abstract class SurveyState extends Equatable{}

class SurveyInitial extends SurveyState {
  @override
  List<Object?> get props => [];
}

class SurveyLoadingState extends SurveyState {
  @override
  List<Object?> get props => [];
}

class SurveyLocationFetchedState extends SurveyState {
  final String pinCode;
  final String village;
  final String district;
  final String state;

  SurveyLocationFetchedState({required this.pinCode, required this.village, required this.district, required this.state});

  @override
  List<Object?> get props => [];
}

class SurveyDataLoadedState extends SurveyState {
  final List<QuestionModel> questions;
  SurveyDataLoadedState({required this.questions});

  @override
  List<Object?> get props => [questions];
}

class SurveyMoveNextQuestionState extends SurveyState {
  final int index;
  SurveyMoveNextQuestionState({required this.index});

  @override
  List<Object?> get props => [index];
}

class SurveyErrorState extends SurveyState {
  final String message;
  SurveyErrorState({required this.message});

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SurveyDataFetchedState extends SurveyState {
  @override
  List<Object?> get props => [];
}

class SurveySuccessState extends SurveyState {
  @override
  List<Object?> get props => [];
}

class SurveyFinishState extends SurveyState {
  @override
  List<Object?> get props => [];
}

class SurveyLocationLoadingState extends SurveyState {
  @override
  List<Object?> get props => [];
}