import 'package:truck_mandi/data/network/base_api_services.dart';
import 'package:truck_mandi/domain/model/notification_model.dart';
import 'package:truck_mandi/domain/model/user.dart';

abstract class ProfileRepository {
  // Sign up with phone
  Future<User> fetchMyProfile();

  Future<dynamic> editProfile(dynamic data, List<UploadFile>? files);

  Future<NotificationModel> fetchMyNotifications();
  Future<Map<String, dynamic>> deleteAccount();
  Future<Map<String, dynamic>> updateFcm(dynamic data);
  Future<dynamic> markNotificationsAsRead(String notificationId, dynamic data);
}
