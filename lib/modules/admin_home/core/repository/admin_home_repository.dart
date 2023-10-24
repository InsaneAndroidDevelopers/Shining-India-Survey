import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/services/network_service.dart';
import 'package:shining_india_survey/values/app_urls.dart';

class AdminHomeRepository {
  final NetworkService _networkService = NetworkService();

  Future<bool> adminLogout() async {
    final token = await SharedPreferencesHelper.getUserToken();
    final userId = await SharedPreferencesHelper.getUserId();
    final Response response = await _networkService.get(
        path: AppUrls.adminLogout,
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