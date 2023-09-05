import 'package:shining_india_survey/modules/survey/core/models/question_response.dart';
import 'location_model.dart';

class SurveyResponseModel {
  String? name;
  String? gender;
  int? age;
  double? latitude;
  double? longitude;
  LocationModel? locationModel;
  List<QuestionResponseModel>? questionResponses;
  String? phone;
  String? address;
  String? religion;
  String? caste;

  SurveyResponseModel({
    this.name,
    this.gender,
    this.age,
    this.latitude,
    this.longitude,
    this.locationModel,
    this.questionResponses,
    this.phone,
    this.address,
    this.caste,
    this.religion
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    data['location'] = {
      'latitude': latitude,
      'longitude': longitude,
      'village': locationModel?.village,
      'district': locationModel?.stateDistrict,
      'state': locationModel?.state,
      'pin': locationModel?.postcode
    };
    data['questions_responses'] = questionResponses?.map((ques) => ques.toJson());
    data['phone'] = phone;
    data['address'] = address;
    data['religion'] = religion;
    data['caste'] = caste;
    return data;
  }
}