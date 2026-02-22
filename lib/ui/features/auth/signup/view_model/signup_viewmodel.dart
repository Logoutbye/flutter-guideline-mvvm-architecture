import 'package:flutter/material.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/data/repository/auth_api/auth_http_api_repository.dart';
import 'package:truck_mandi/data/repository/auth_api/auth_repository.dart';
import 'package:truck_mandi/ui/features/auth/login/view_model/login_view_model.dart';
import 'package:truck_mandi/ui/features/dashboard/view/dashboard.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository signUpRepository = AuthHttpApiRepository();

  SignUpViewModel();

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signupEmail(
    BuildContext context,
    Map<String, String> data,
  ) async {
    setLoading(true);
    try {
      var response = await signUpRepository.signUpEmail(data);
      var token = response['token'];
      LoginViewModel().handleAuth(context, token, Dashboard());
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
    } finally {
      setLoading(false);
    }
  }
}
