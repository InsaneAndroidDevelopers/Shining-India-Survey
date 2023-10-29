import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/survey/core/models/location_model.dart';
import 'package:shining_india_survey/modules/survey/core/models/question_model.dart';
import 'package:shining_india_survey/modules/survey/core/models/survey_submit_model.dart';
import 'package:shining_india_survey/services/network_service.dart';
import 'package:shining_india_survey/values/app_urls.dart';

class SurveyRepository {
  final NetworkService _networkRequester = NetworkService();

  Future<LocationModel> getAddressFromLatLng(
      double latitude,
      double longitude
    ) async {
    final Response response = await _networkRequester.get(
        path: "https://geocode.maps.co/reverse",
        query: {
          "lat": latitude,
          "lon": longitude
        },
        token: ''
    );
    return LocationModel.fromJson(response.data?['address']);
  }

  Future<List<QuestionModel>> getSurveyQuestions({required String placeType}) async {
    final userId = await SharedPreferencesHelper.getUserId();
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkRequester.get(
      path: '${AppUrls.surveyorGetSurveyQuestions}/${placeType.toLowerCase()}/$userId',
      token: token
    );
    final List questionList = response.data['data'];
    return questionList
        .map((e) => QuestionModel.fromJson(e))
        .toList();
  }

  Future submitSurvey({required SurveySubmitModel surveySubmitModel}) async {
    final token = await SharedPreferencesHelper.getUserToken();
    await _networkRequester.post(
      token: token,
      data: surveySubmitModel.toJson(),
      path: AppUrls.surveyorSubmitSurvey
    );
  }
}
