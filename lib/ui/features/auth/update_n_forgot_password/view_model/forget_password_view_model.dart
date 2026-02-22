import 'package:flutter/material.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/data/repository/auth_api/auth_http_api_repository.dart';
import 'package:truck_mandi/data/repository/auth_api/auth_repository.dart';
import 'package:truck_mandi/ui/features/auth/update_n_forgot_password/view/reset_password_otp_screen.dart';
import 'package:truck_mandi/ui/features/auth/update_n_forgot_password/view/change_password_screen.dart';

class ForgetPasswordViewModel with ChangeNotifier {
  final AuthRepository authRepository = AuthHttpApiRepository();

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> forgotPassword(BuildContext context, email) async {
    setLoading(true);
    try {
      Map data = {'email': email};
      await authRepository.forgotPassword(data);
      setLoading(false);
      Utils.toastMessage('Code Sent successfully on your email');
      MyNavigationService.push(ResetPasswordVerifyOtpScreen(email: email));
    } catch (error) {
      Utils.toastMessage('Failed to send code. Please try again.');
      setLoading(false);
    }
  }

  Future<void> verifyOtp(BuildContext context, email, verificationCode) async {
    try {
      setLoading(true);
      var data = {'verificationCode': verificationCode, 'email': email};
      await authRepository.verifyEmailOtp(data);
      setLoading(false);

      Utils.toastMessage('Otp verified successfully');
      MyNavigationService.push(
        ChangePasswordScreen(email: email, verificationCode: verificationCode),
      );
    } catch (error) {
      Utils.toastMessage('Failed to verify OTP. Please try again.');
      setLoading(false);
    }
  }

  Future<void> resetPassword(BuildContext context, dynamic data) async {
    setLoading(true);
    try {
      authRepository.resetPassword(data);
      setLoading(false);
      Utils.toastMessage('Password changed successfully');
    } catch (error) {
      Utils.toastMessage('Failed to change password.');
      setLoading(false);
    }
  }
}
