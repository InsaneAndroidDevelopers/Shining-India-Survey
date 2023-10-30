import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/services/network_service.dart';
import 'package:shining_india_survey/values/app_urls.dart';

class CreateUpdateSurveyorRepository {
  final NetworkService _networkService = NetworkService();

  Future getAllTeams() async {
    final token = await SharedPreferencesHelper.getUserToken();
    final userId = await SharedPreferencesHelper.getUserId();
    final Response response = await _networkService.get(
        path: AppUrls.adminGetAllTeams,
        query: {
          'id': userId
        },
        token: token
    );
    return;
  }

  Future<bool> createTeam({required String teamName}) async {
    final token = await SharedPreferencesHelper.getUserToken();
    final userId = await SharedPreferencesHelper.getUserId();
    final Response response = await _networkService.post(
      path: AppUrls.adminCreateTeam,
      query: {
        'id': userId
      },
      data: {
        'teamName': teamName
      },
      token: token
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> createSurveyor({required String teamName}) async {
    final token = await SharedPreferencesHelper.getUserToken();
    final userId = await SharedPreferencesHelper.getUserId();
    final Response response = await _networkService.post(
        path: AppUrls.adminCreateSurveyor,
        query: {
          'id': userId
        },
        data: {
          'teamName': teamName
        },
        token: token
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }
}