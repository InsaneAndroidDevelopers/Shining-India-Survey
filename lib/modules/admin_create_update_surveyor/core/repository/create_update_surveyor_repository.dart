import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/services/network_service.dart';
import 'package:shining_india_survey/global/values/app_urls.dart';

class CreateUpdateSurveyorRepository {
  final NetworkService _networkService = NetworkService();

  Future<List<TeamModel>> getAllTeams() async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.get(
        path: AppUrls.adminGetAllTeams,
        token: token
    );
    final List list = response.data['data'];
    return list.map((e) => TeamModel.fromJson(e)).toList();
  }

  Future<bool> createTeam({required String teamName}) async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.post(
      path: AppUrls.adminCreateTeam,
      data: {
        'teamName': teamName
      },
      token: token
    );
    if(response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<String> createSurveyor({required String name, required String email, required String password}) async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.post(
      path: AppUrls.adminCreateSurveyor,
      data: {
        'name': name,
        'email': email,
        'password': password
      },
      token: token
    );
    if(response.statusCode == 201) {
      return response.data['data']['id'];
    }
    return '';
  }

  Future<bool> addSurveyorIntoTeam({required String teamId, required String surveyorId}) async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.post(
        path: AppUrls.adminAddSurveyorIntoTeam,
        data: {
          'teamId': teamId,
          'members': [surveyorId],
        },
        token: token
    );
    if(response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> removeSurveyor({required String teamId, required String surveyorId}) async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.put(
        path: AppUrls.adminDeleteSurveyor,
        data: {
          'teamId': teamId,
          'members': [surveyorId],
        },
      token: token
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> updateSurveyorStatus({required String surveyorId, required bool isActive, String? password}) async  {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.put(
        path: '${AppUrls.adminUpdateSurveyor}/$surveyorId',
        data: {
          'active': isActive,
          'password': password ?? ''
        },
        token: token
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }
}