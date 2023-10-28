import 'package:dio/dio.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/survey/core/models/location_model.dart';
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

  // Future<> getSurveyQuestions({required String placeType}) async {
  //   final token = await SharedPreferencesHelper.getUserToken();
  //   final Response response = await _networkRequester.get(
  //     path: AppUrls.surveyorGetSurveyQuestions,
  //     token: token
  //   );
  //   return
  // }
}
