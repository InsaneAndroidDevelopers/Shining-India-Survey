import 'package:dio/dio.dart';
import 'package:shining_india_survey/modules/survey/core/models/location_model.dart';
import 'package:shining_india_survey/services/network_service.dart';

class SurveyRepository {
  final NetworkService _networkRequester = NetworkService();

  Future<LocationModel> getAddressFromLatLng(
      double latitude, double longitude) async {
    try {
      final Map<String, double> queryParams = {
        "lat": latitude,
        "lon": longitude
      };
      final Response response = await _networkRequester.get(
          path: "https://geocode.maps.co/reverse",
          query: queryParams,
          token: ''
      );
      final Map<String, dynamic> res = response.data?['address'];
      return LocationModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
