abstract class AuthRepository {
  Future<Map<String, dynamic>> signInEmail(dynamic data);
  Future<Map<String, dynamic>> signUpEmail(dynamic data);

  Future<Map<String, dynamic>> forgotPassword(dynamic data);

  // Sign up with email
  Future<Map<String, dynamic>> resetPassword(dynamic data);
  Future<Map<String, dynamic>> verifyEmailOtp(dynamic data);
}
