part of 'survey_bloc.dart';

@immutable
abstract class SurveyEvent extends Equatable{}

class FetchLocationFromLatLngEvent extends SurveyEvent {
  final double latitude;
  final double longitude;

  FetchLocationFromLatLngEvent({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [];
}

class SubmitDetailsAndStartSurveyEvent extends SurveyEvent {
  final String name;
  final String gender;
  final int age;
  final double latitude;
  final double longitude;
  final String placeType;
  final String assemblyName;
  final String dateTime;
  final String city;
  final LocationModel locationModel;

  SubmitDetailsAndStartSurveyEvent({
    required this.locationModel,
    required this.longitude,
    required this.latitude,
    required this.gender,
    required this.name,
    required this.age,
    required this.placeType,
    required this.assemblyName,
    required this.dateTime,
    required this.city
  });

  @override
  List<Object> get props => [];

}

class LoadFetchedDataEvent extends SurveyEvent {
  final List<QuestionModel> list;
  LoadFetchedDataEvent({required this.list});

  @override
  List<Object> get props => [];
}

class CheckQuestionResponseEvent extends SurveyEvent {
  final QuestionModel question;
  final int index;

  CheckQuestionResponseEvent({required this.index, required this.question});
  @override
  List<Object> get props => [];
}

class SubmitAdditionalDetailsAndFinishEvent extends SurveyEvent {
  final String mobileNum;
  final String religion;
  final String caste;
  final String address;

  SubmitAdditionalDetailsAndFinishEvent({
    required this.mobileNum,
    required this.religion,
    required this.caste,
    required this.address
  });

  @override
  List<Object?> get props => [];
}

class SkipAndFinishSurveyEvent extends SurveyEvent {
  @override
  List<Object?> get props => [];
}

class SkipQuestionEvent extends SurveyEvent {
  final QuestionModel question;
  final int index;

  SkipQuestionEvent({required this.index, required this.question});
  @override
  List<Object?> get props => [];
}