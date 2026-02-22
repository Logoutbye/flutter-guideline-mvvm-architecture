import 'package:flutter/material.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/configs/utils/my_logger.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/data/repository/auth_api/auth_http_api_repository.dart';
import 'package:truck_mandi/data/repository/auth_api/auth_repository.dart';
import 'package:truck_mandi/ui/features/dashboard/view/dashboard.dart';
import 'package:truck_mandi/ui/features/splash/view_model/session_controller.dart';

class LoginViewModel with ChangeNotifier {
  final AuthRepository authRepository = AuthHttpApiRepository();

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signinWithEmail(BuildContext context, dynamic data) async {
    setLoading(true);
    try {
      var response = await authRepository.signInEmail(data);

      setLoading(false);
      Utils.toastMessage('Login Successfully');
      handleAuth(context, response['token'], Dashboard());
    } catch (error) {
      MyLogger.info(error.toString());
      Utils.toastMessage('Failed to Login. Please try again.');
      setLoading(false);
    }
  }

  void handleAuth(BuildContext context, String token, Widget navigateTo) {
    try {
      SessionController().saveToken(token);
      SessionController().getUserToken();

      MyNavigationService.pushAndRemoveAll(navigateTo);
    } catch (error) {
      Utils.toastMessage('Error: ${error.toString()}');
    }
  }
}
