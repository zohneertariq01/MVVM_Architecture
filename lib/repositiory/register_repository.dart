import 'package:clear_view_model/data/network/base_api_services.dart';
import 'package:clear_view_model/data/network/network_api_services.dart';
import 'package:clear_view_model/res/components/app_urls.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.loginEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signupApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.registerEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
