import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/services/network_service.dart';
import 'package:shining_india_survey/values/app_urls.dart';

class FilledSurveyRepository {
  final NetworkService _networkService = NetworkService();

  Future<List<SurveyResponseModel>> getAllSurveys({required int page}) async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.get(
      path: AppUrls.adminGetAllSurveys,
      query: {
        'page': page,
        'size': 10
      },
      token: token
    );
    final List list = response.data['data']['content'];
    return list.map((e) => SurveyResponseModel.fromJson(e)).toList();
  }

  Future<List<SurveyResponseModel>> getFilteredSurveys({
    String? gender,
    String? fromDate,
    String? toDate,
    String? teamId,
    required int page
  }) async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.post(
      path: AppUrls.adminFilterSurveys,
      data: {
        'gender': gender,
        'fromDate': fromDate,
        'toDate': toDate,
        'teamId': teamId
      },
      query: {
        'page': page,
        'size': 10
      },
      token: token
    );
    final List list = response.data['data'];
    return list.map((e) => SurveyResponseModel.fromJson(e)).toList();
  }
}