part of 'filled_survey_bloc.dart';

abstract class FilledSurveyState extends Equatable {
  const FilledSurveyState();
}

class FilledSurveyInitial extends FilledSurveyState {
  const FilledSurveyInitial();

  @override
  List<Object> get props => [];
}

class FilledSurveyLoading extends FilledSurveyState {
  // final List<SurveyResponseModel> oldList;
  // final bool isFirstFetch;
  // const FilledSurveyLoading({required this.oldList, this.isFirstFetch = false});

  @override
  List<Object> get props => [];
}

class FilledSurveyError extends FilledSurveyState {
  final String message;
  const FilledSurveyError({required this.message});

  @override
  List<Object> get props => [];
}

class FilledSurveyFetched extends FilledSurveyState {
  final List<SurveyResponseModel> list;
  const FilledSurveyFetched({required this.list});

  @override
  List<Object?> get props => [];
}

class FilterSurveysLoading extends FilledSurveyState {
  @override
  List<Object?> get props => [];
}

class FilterSurveysFetched extends FilledSurveyState {
  final List<SurveyResponseModel> filterList;

  const FilterSurveysFetched({required this.filterList});

  @override
  List<Object?> get props => [];
}

