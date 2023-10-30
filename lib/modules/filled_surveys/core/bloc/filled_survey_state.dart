part of 'filled_survey_bloc.dart';

abstract class FilledSurveyState extends Equatable {
  final surveys;
  const FilledSurveyState(this.surveys);
}

class FilledSurveyInitial extends FilledSurveyState {
  const FilledSurveyInitial(super.surveys);

  @override
  List<Object> get props => [];
}

class FilledSurveyLoading extends FilledSurveyState {
  const FilledSurveyLoading(super.surveys);

  @override
  List<Object> get props => [];
}

class FilledSurveyError extends FilledSurveyState {
  final String message;
  const FilledSurveyError(super.surveys, {required this.message});

  @override
  List<Object> get props => [];
}

class FilledSurveyFetched extends FilledSurveyState {
  const FilledSurveyFetched({required surveys}) : super(surveys);

  @override
  List<Object?> get props => [];
}
