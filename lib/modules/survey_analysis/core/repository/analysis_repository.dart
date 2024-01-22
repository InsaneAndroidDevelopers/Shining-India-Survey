import 'dart:math';

import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/analysis_response_model.dart';
import 'package:shining_india_survey/services/network_service.dart';
import 'package:shining_india_survey/global/values/app_urls.dart';

class AnalysisRepository {
  final NetworkService _networkService = NetworkService();

  Future<List<AnalysisResponseModel>> getAnalysis() async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.post(
      path: AppUrls.adminAnalyseSurveys,
      token: token,
      data: {}
    );
    final List list = response.data['data'];
    return list.map((e) => AnalysisResponseModel.fromJson(e)).toList();
  }

  Future<List<AnalysisResponseModel>> getFilteredAnalysis({
   String? gender,
   String? teamId,
   int? minAge,
   int? maxAge,
   String? fromDate,
   String? toDate,
   String? state
  }) async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.post(
        path: AppUrls.adminAnalyseSurveys,
        token: token,
        data: {
          'gender': gender,
          'teamId': teamId,
          'minAge': minAge,
          'maxAge': maxAge,
          'fromDate': fromDate,
          'toDate': toDate,
          'state': state
        }
    );
    final List list = response.data['data'];
    return list.map((e) => AnalysisResponseModel.fromJson(e)).toList();
  }
}