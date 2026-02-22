import 'dart:convert';
import '../../network/base_api_services.dart';
import '../../network/network_api_services.dart';
import '../../network/app_url.dart';
import 'auth_repository.dart';

class AuthHttpApiRepository implements AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  @override
  Future<Map<String, dynamic>> signInEmail(dynamic data) async {
    dynamic response = await _apiServices.postApiResponse(
      AppUrl.loginInEmail,
      jsonEncode(data),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> signUpEmail(dynamic data) async {
    dynamic response = await _apiServices.postApiResponse(
      AppUrl.signInEmail,
      jsonEncode(data),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(dynamic data) async {
    try {
      final response = await _apiServices.postApiResponse(
        AppUrl.forgotPassword,
        jsonEncode(data),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> resetPassword(dynamic data) async {
    try {
      final response = await _apiServices.postApiResponse(
        AppUrl.resetPassword,
        jsonEncode(data),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> verifyEmailOtp(dynamic data) async {
    try {
      final response = await _apiServices.postApiResponse(
        AppUrl.verifyPasswordOtp,
        jsonEncode(data),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
