import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/services/network_service.dart';
import 'package:shining_india_survey/global/values/app_urls.dart';

class AdminHomeRepository {
  final NetworkService _networkService = NetworkService();

  Future<bool> adminLogout() async {
    final token = await SharedPreferencesHelper.getUserToken();
    final Response response = await _networkService.post(
        path: AppUrls.adminLogout,
        token: token
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }
}