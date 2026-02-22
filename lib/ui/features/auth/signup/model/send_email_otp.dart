class SendEmailOtpResponse {
  final bool success;
  final String message;

  SendEmailOtpResponse({required this.success, required this.message});

  // Factory constructor to create the object from JSON response
  factory SendEmailOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendEmailOtpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
