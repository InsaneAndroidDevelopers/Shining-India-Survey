import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/login/core/models/admin_response_model.dart';
import 'package:shining_india_survey/modules/login/core/models/surveyor_response_model.dart';
import 'package:shining_india_survey/modules/survey/core/models/question_model.dart';
import 'package:shining_india_survey/services/network_service.dart';
import 'package:shining_india_survey/global/values/app_urls.dart';

class LoginRepository {
  final NetworkService _networkService = NetworkService();

  Future<AdminResponseModel> adminLogin({
    required String email,
    required String password
  }) async {
    final Response response = await _networkService.post(
        path: AppUrls.adminLogin,
        data: {
          'email': email,
          'password': password
        },
      token: null
    );
    if(response.statusCode == 200) {
      print(response.data['jwt']);
      await SharedPreferencesHelper.setUserToken(response.data['jwt']);
    }
    return AdminResponseModel.fromJson(response.data['data']);
  }

  Future<SurveyorResponseModel> surveyorLogin({
    required String email,
    required String password
  }) async {
    final Response response = await _networkService.post(
        path: AppUrls.surveyorLogin,
        data: {
          'email': email,
          'password': password
        },
        token: null
    );
    if(response.statusCode == 200) {
      print(response.data['jwt']);
      await SharedPreferencesHelper.setUserToken(response.data['jwt']);
    }
    return SurveyorResponseModel.fromJson(response.data['data']);
  }

  Future<List<QuestionModel>> getSurveyQuestions({required String placeType}) async {
    final userId = await SharedPreferencesHelper.getUserId();
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.get(
        path: '${AppUrls.surveyorGetSurveyQuestions}/${placeType.toLowerCase()}/$userId',
        token: token
    );
    final List questionList = response.data['data'];
    return questionList
        .map((e) => QuestionModel.fromJson(e))
        .toList();
  }
}