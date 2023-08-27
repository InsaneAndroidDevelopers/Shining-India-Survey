part of 'survey_bloc.dart';

@immutable
abstract class SurveyEvent extends Equatable{}

class SubmitDetailsAndStartSurveyEvent extends SurveyEvent {
  @override
  List<Object?> get props => [];

}

class LoadFetchedDataEvent extends SurveyEvent {
  @override
  List<Object?> get props => [];
}

class CheckQuestionResponseEvent extends SurveyEvent {
  final int index;

  CheckQuestionResponseEvent({required this.index});
  @override
  List<Object?> get props => [];
}

class GetSelectedOptionsDetailsEvent extends SurveyEvent {
  final int? selectedIndex;
  final List<int>? selectedOptionsIndex;
  final String? othersText;

  GetSelectedOptionsDetailsEvent({
    this.selectedIndex,
    this.selectedOptionsIndex,
    this.othersText
  });
  @override
  List<Object?> get props => [];
}

class SubmitAdditionalDetailsAndFinishEvent extends SurveyEvent {
  @override
  List<Object?> get props => [];
}

class SkipAndFinishSurveyEvent extends SurveyEvent {
  @override
  List<Object?> get props => [];
}