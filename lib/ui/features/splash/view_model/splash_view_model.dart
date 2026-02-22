// Correct placement of directives
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/configs/utils/my_logger.dart';
import 'package:truck_mandi/ui/features/auth/login/view/login_view_with_email.dart';
import 'package:truck_mandi/ui/features/dashboard/view/dashboard.dart';
import 'package:truck_mandi/ui/features/splash/view_model/session_controller.dart';

class SplashViewModel extends ChangeNotifier {
  bool _isLogin = false;
  bool _isLoading = true;
  bool _isInternetCheckerLoading = false;
  bool get isLogin => _isLogin;
  bool get isLoading => _isLoading;
  bool get isInternetCheckerLoading => _isInternetCheckerLoading;
  // NotificationServices notificationServices = NotificationServices();

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setIsInterNetLoading(bool isLoading) {
    _isInternetCheckerLoading = isLoading;
    notifyListeners();
  }

  void updateLoginState(bool isLogin) {
    _isLogin = isLogin;
    notifyListeners();
  }

  void checkAuthentication(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));

    setLoading(true);
    setIsInterNetLoading(true);

    SessionController()
        .getUserToken()
        .then((value) async {
          final isLogin = SessionController().token != null;
          MyLogger.info(SessionController().token.toString());
          updateLoginState(isLogin);

          if (isLogin) {
            MyNavigationService.pushAndRemoveAll(Dashboard());
          } else {
            setLoading(false);
            setIsInterNetLoading(false);
            MyNavigationService.pushAndRemoveAll(LoginViewWithEmail());
          }
        })
        .onError((error, stackTrace) {
          setLoading(false);
          setIsInterNetLoading(false);
        });
  }
}
