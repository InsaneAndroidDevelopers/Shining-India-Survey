import 'package:dio/dio.dart';
import 'package:shining_india_survey/global/values/app_urls.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/admin_reassign_surveyor/core/model/unassigned_surveyor_model.dart';
import 'package:shining_india_survey/services/network_service.dart';

class SurveyorUnassignedRepository {

  final NetworkService _networkService = NetworkService();

  Future<List<UnassignedSurveyorModel>> getAllUnassignedSurveyors() async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.get(
        path: AppUrls.adminUnassignedSurveyors,
        token: token
    );
    final List list = response.data['data'];
    return list.map((e) => UnassignedSurveyorModel.fromJson(e)).toList();
  }
}