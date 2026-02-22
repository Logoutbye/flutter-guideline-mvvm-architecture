import 'dart:io';

import 'package:flutter/foundation.dart';

class AppUrl {
  static String socketUrl = "ws://";

  static const String _liveBaseUrl = "http";

  static late String baseUrl;

  static Future<void> init() async {
    if (kDebugMode) {
      final localIp = await _getLocalIp();
      if (localIp != null) {
        baseUrl = 'http://$localIp:8000/api';
      } else {
        print('⚠️ Local IP not found, using live URL');
        baseUrl = _liveBaseUrl;
      }
    } else {
      baseUrl = _liveBaseUrl;
    }
  }

  static Future<String?> _getLocalIp() async {
    try {
      final interfaces = await NetworkInterface.list();

      for (var interface in interfaces) {
        if (interface.name == 'en0') {
          for (var addr in interface.addresses) {
            if (addr.type == InternetAddressType.IPv4) {
              return addr.address;
            }
          }
        }
      }
    } catch (e) {
      debugPrint('❌ Error getting IP: $e');
    }

    return null;
  }

  static var loginInEmail = '$baseUrl/auth/signInEmail';
  static var signInEmail = '$baseUrl/auth/signInEmail';

  static var forgotPassword = '$baseUrl/auth/forgot-password';
  static var verifyPasswordOtp = '$baseUrl/auth/verify-otp-reset-password';
  static var resetPassword = '$baseUrl/auth/reset-password';
  static var notifications = "$baseUrl/profile/notifications";

  /////

  static var sendEmailOtp = '$baseUrl/auth/send-email-otp'; // done
  static var sendPhoneOtp = '$baseUrl/auth/send-phone-otp'; // done
  static var verifyPhoneOtp = '$baseUrl/auth/verify-phone-otp'; // done
  static var reSendPhoneOtp = '$baseUrl/auth/otp/send';

  static var signupEmail = '$baseUrl/auth/sign-up-email';

  static var selectAccountMode = '$baseUrl/auth/select-account-mode';
  static var completeProfile = '$baseUrl/auth/send-otp';

  static var verifyOtpResetPassword = '$baseUrl/auth/verify-otp-reset-password';
  static var changePassword = '$baseUrl/auth/change-password';
  static var myprofile = '$baseUrl/profile/';
  static var editprofile = '$baseUrl/profile/edit-profile';
  static var checkVerification = '$baseUrl/profile/check-verification';
  static var verifyIndividualAccount =
      '$baseUrl/profile/verify-individual-account';
  static var verifyShopAccount = '$baseUrl/profile/verify-shop-account';
  static var toggleFavoriteAd = '$baseUrl/profile/favorites/toggleFavorite';
  static var myFavorite = '$baseUrl/profile/favorites/';

  static var createVehicleAd = '$baseUrl/vehicle-ad/create';
  static var myVehicleAds = '$baseUrl/vehicle-ad/my-ads';
  static var adDetail = '$baseUrl/vehicle-ad/get-ad-details';
  static var allVehicleAds = '$baseUrl/vehicle-ad/all';

  static var createSparePartAd = '$baseUrl/sparepart-ad/create';

  static String markAsSoldVehicle(String adType, String itemId) =>
      '$baseUrl/vehicle-ad/mark-as-sold/${adType.replaceAll(' ', '')}/$itemId';

  static String removeAd(String adType, String itemId) =>
      '$baseUrl/vehicle-ad/remove/${adType.replaceAll(' ', '')}/$itemId';
  static var shops = '$baseUrl/users/shops'; // Add this line

  static var uploadMedia = "$baseUrl/chat/upload-file";

  static var deleteAccount = "$baseUrl/auth/delete-account";
  static var googleAuth = "$baseUrl/auth/google-auth";
  static var appleAuth = "$baseUrl/auth/apple-auth";

  // static const fetchNews = "$baseUrl/profile/get-news";
  static var fetchVideos = "$baseUrl/vehicle-ad/get-videos";
  static var submitContactRequest = "$baseUrl/users/contact-us";
  static var updateFCM = "$baseUrl/profile/fcm-Token";
  static var vehicleAdVideos = "$baseUrl/vehicle-ad/get-vehicle-videos";
  static var spareAdVideos = "$baseUrl/vehicle-ad/get-sparepart-videos";
  static String markNotificationsAsRead(String notificationId) =>
      "$baseUrl/profile/notifications/$notificationId/read";
  static String deleteChat(String chatId) => "$baseUrl/chat/$chatId";
}
