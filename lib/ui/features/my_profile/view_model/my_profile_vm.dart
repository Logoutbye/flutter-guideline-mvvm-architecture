import 'package:flutter/material.dart';
import 'package:truck_mandi/configs/utils/my_logger.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/data/repository/profile_api/profile_http_api_repository.dart';
import 'package:truck_mandi/data/repository/profile_api/profile_repository.dart';
import 'package:truck_mandi/data/response/api_response.dart';
import 'package:truck_mandi/data/response/base_response.dart';
import 'package:truck_mandi/domain/model/user.dart';
import 'package:truck_mandi/ui/features/splash/view_model/session_controller.dart';

class ProfileVM with ChangeNotifier {
  final ProfileRepository profileRepository = ProfileHttpApiRepository();

  ApiResponse<User> myProfile = ApiResponse.notStarted();

  void setProfile(ApiResponse<User> response) {
    myProfile = response;
    notifyListeners();
  }

  Future<void> fetchMyProfileApi() async {
    if (myProfile.data == null) {
      setProfile(ApiResponse.loading());
    }

    profileRepository
        .fetchMyProfile()
        .then((value) {
          setProfile(ApiResponse.completed(value));
        })
        .onError((error, stackTrace) {
          setProfile(ApiResponse.error(error.toString()));
        });
  }

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      setLoading(true);
      var response = await profileRepository.deleteAccount();
      BaseApiResponse baseApiResponse = BaseApiResponse.fromJson(response);
      Utils.toastMessage(
        baseApiResponse.message ?? 'Account deleted Successfully',
      );
      SessionController().logout(context);
      setLoading(false);
    } catch (error) {
      setLoading(false);
    }
  }

  Future<void> updateFCM(BuildContext context, dynamic data) async {
    try {
      await profileRepository.updateFcm(data);
    } catch (error) {
      MyLogger.error(error.toString());
    }
  }
}
