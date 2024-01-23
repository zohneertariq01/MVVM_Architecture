import 'package:clear_view_model/data/response/api_response.dart';
import 'package:clear_view_model/model/apna_model.dart';
import 'package:clear_view_model/repositiory/home_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<ApnaModel> shoppingList = ApiResponse.loading();

  setShoppingList(ApiResponse<ApnaModel> response) {
    shoppingList = response;
    notifyListeners();
  }

  Future<void> fetchShoppingList() async {
    setShoppingList(ApiResponse.loading());
    _myRepo.fetchShoppingApi().then((value) {
      setShoppingList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setShoppingList(ApiResponse.error(error.toString()));
    });
  }
}
