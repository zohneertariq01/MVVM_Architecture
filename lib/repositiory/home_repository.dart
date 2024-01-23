import 'package:clear_view_model/data/network/base_api_services.dart';
import 'package:clear_view_model/data/network/network_api_services.dart';
import 'package:clear_view_model/model/apna_model.dart';
import '../res/components/app_urls.dart';

class HomeRepository {
  Future<ApnaModel> fetchShoppingApi() async {
    BaseApiServices _apiServices = NetworkApiServices();
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrls.recipeEndPoint);
      return response = ApnaModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
