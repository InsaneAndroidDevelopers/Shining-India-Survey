import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/models/surveyor_home_reponse_model.dart';
import 'package:shining_india_survey/services/network_service.dart';
import 'package:shining_india_survey/values/app_urls.dart';

class SurveyorHomeRepository {
  final NetworkService _networkService = NetworkService();

  Future<List<SurveyorHomeResponseModel>> getRecentSurveys() async {
    final token = await SharedPreferencesHelper.getUserToken();
    final userId = await SharedPreferencesHelper.getUserId();
    final Response response = await _networkService.get(
        path: AppUrls.surveyorRecent,
        query: {
          'id': userId
        },
        token: token
    );
    final List surveyList = response.data['data'];
    return surveyList
        .map((e) => SurveyorHomeResponseModel.fromJson(e))
        .toList();
  }

  Future<bool> surveyorLogout() async {
    final token = await SharedPreferencesHelper.getUserToken();
    final userId = await SharedPreferencesHelper.getUserId();
    final Response response = await _networkService.get(
      path: AppUrls.surveyorLogout,
      query: {
        'id': userId
      },
      token: token
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }
}