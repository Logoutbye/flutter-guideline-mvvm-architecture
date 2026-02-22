import 'package:truck_mandi/data/network/app_url.dart';
import 'package:truck_mandi/data/network/base_api_services.dart';
import 'package:truck_mandi/data/network/network_api_services.dart';
import 'package:truck_mandi/domain/model/notification_model.dart';
import 'package:truck_mandi/domain/model/user.dart';
import 'package:truck_mandi/ui/features/splash/view_model/session_controller.dart';

import 'profile_repository.dart';

class ProfileHttpApiRepository implements ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  @override
  Future<User> fetchMyProfile() async {
    try {
      String? token = SessionController().token;
      if (token != null) {
        final response = await _apiServices.fetchGetApiResponse(
          AppUrl.myprofile,
        );

        final Map<String, dynamic> responseData = response;
        print('"""${response}"""');
        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('user')) {
          return User.fromJson(responseData['data']['user']);
        } else {
          throw Exception("Invalid response format: Missing 'user' field.");
        }
      } else {
        throw Exception("Token is null");
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> editProfile(dynamic data, List<UploadFile>? files) async {
    try {
      final response = await _apiServices.postApiResponse(
        AppUrl.editprofile,
        data,
        files: files,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<NotificationModel> fetchMyNotifications() async {
    try {
      final response = await _apiServices.fetchGetApiResponse(
        AppUrl.notifications,
      );
      final notificationModel = NotificationModel.fromJson(response);
      return notificationModel;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      final response = await _apiServices.deleteApiResponse(
        AppUrl.deleteAccount,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> updateFcm(data) async {
    try {
      final response = await _apiServices.postApiResponse(
        AppUrl.updateFCM,
        data,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future markNotificationsAsRead(String notificationId, data) async {
    try {
      final response = await _apiServices.patchApiResponse(
        AppUrl.markNotificationsAsRead(notificationId),
        data: data,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
