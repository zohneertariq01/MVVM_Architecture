import 'package:clear_view_model/model/user_model.dart';
import 'package:clear_view_model/repositiory/register_repository.dart';
import 'package:clear_view_model/utils/routes/routes.dart';
import 'package:clear_view_model/utils/utils.dart';
import 'package:clear_view_model/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signupLoading = false;
  bool get signupLoading => _signupLoading;

  void setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  void setSignupLoading(value) {
    _signupLoading = value;
    notifyListeners();
  }

  Future<void> loginApiProvider(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final provider = Provider.of<UserViewModel>(context, listen: false);
      provider.saveUser(
        UserModel(token: value['token'].toString()),
      );
      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> signupApiProvider(dynamic data, BuildContext context) async {
    setSignupLoading(true);
    _myRepo.signupApi(data).then((value) {
      setSignupLoading(false);
      Utils.flushBarErrorMessage('Signup Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignupLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
