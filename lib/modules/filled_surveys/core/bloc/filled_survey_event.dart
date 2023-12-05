part of 'filled_survey_bloc.dart';

abstract class FilledSurveyEvent extends Equatable {
  const FilledSurveyEvent();
}

class FetchAllSurveys extends FilledSurveyEvent {
  final bool isFirstFetch;
  const FetchAllSurveys({required this.isFirstFetch});

  @override
  List<Object?> get props => [];
}

class FetchMoreSurveys extends FilledSurveyEvent {
  @override
  List<Object?> get props => [];
}

class FilterSurveys extends FilledSurveyEvent {
  final String teamId;
  final String fromDate;
  final String toDate;
  final String gender;
  final bool isFirstFetch;

  const FilterSurveys({required this.gender, required this.teamId, required this.fromDate, required this.toDate, required this.isFirstFetch});

  @override
  List<Object?> get props => [];
}
