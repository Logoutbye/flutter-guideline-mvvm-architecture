class BaseApiResponse {
  final bool success;
  final String? message;
  final dynamic data;

  BaseApiResponse({required this.success, this.message, this.data});

  factory BaseApiResponse.fromJson(Map<String, dynamic> json) {
    return BaseApiResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'],
    );
  }
}
