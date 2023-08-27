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
  final Question question;
  final int index;

  CheckQuestionResponseEvent({required this.index, required this.question});
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