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

class SurveyDataLoadedState extends SurveyState {
  final List<Question> questions;
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