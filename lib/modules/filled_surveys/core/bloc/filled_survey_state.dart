part of 'filled_survey_bloc.dart';

abstract class FilledSurveyState extends Equatable {
  const FilledSurveyState();
}

class FilledSurveyInitial extends FilledSurveyState {
  @override
  List<Object> get props => [];
}

class FilledSurveyLoading extends FilledSurveyState {
  @override
  List<Object> get props => [];
}

class FilledSurveyError extends FilledSurveyState {
  @override
  List<Object> get props => [];
}
