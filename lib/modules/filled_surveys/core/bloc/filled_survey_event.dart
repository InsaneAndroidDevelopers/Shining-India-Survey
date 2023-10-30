part of 'filled_survey_bloc.dart';

abstract class FilledSurveyEvent extends Equatable {
  const FilledSurveyEvent();
}

class FetchAllSurveys extends FilledSurveyEvent {
  @override
  List<Object?> get props => [];
}

class FetchMoreSurveys extends FilledSurveyEvent {
  @override
  List<Object?> get props => [];
}
