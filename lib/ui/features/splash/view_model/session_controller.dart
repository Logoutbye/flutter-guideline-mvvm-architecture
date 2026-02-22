import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/ui/features/splash/view/splash_screen.dart';
import 'package:truck_mandi/ui/features/splash/view_model/local_storage.dart';


class SessionController {
  LocalStorage sharedPreferenceClass = LocalStorage();
  static final SessionController _session = SessionController._internal();
  // ProfileRepository profileRepository = ProfileHttpApiRepository();

  bool? isLogin;
  String? _token; // Only store token
  String? get token => _token;

  factory SessionController() => _session;

  SessionController._internal() {
    isLogin = false;
    _token = '';
  }

  // Get token from cache or shared preferences
  Future<String?> getUserToken() async {
    if (_token != null && _token!.isNotEmpty) return _token;

    final SharedPreferences sp = await SharedPreferences.getInstance();
    _token = sp.getString('token');
    return _token;
  }

  // Save token only
  Future<void> saveToken(String token) async {
    try {
      await sharedPreferenceClass.setValue('token', token);
      await sharedPreferenceClass.setValue('isLogin', 'true');

      _token = token;
      isLogin = true;

      debugPrint("Token saved successfully!");
    } catch (e) {
      debugPrint("Error saving token: $e");
    }
  }

  // Clear token and login state
  Future<void> logout(BuildContext context) async {
    try {
      // var data = {'fcmToken': ''};
      // profileRepository.updateProfile(data: data);

      await sharedPreferenceClass.clearValue('token');
      await sharedPreferenceClass.clearValue('isLogin');
      // await googleSignIn.signOut();

      _token = null;
      isLogin = false;

      MyNavigationService.pushAndRemoveAll(SplashScreen());
    } catch (e) {
      debugPrint("Logout error: $e");
    }
  }
}
