import 'dart:io';

class UploadFile {
  final File file;
  final String fieldName;

  UploadFile({required this.file, required this.fieldName});
}

abstract class BaseApiServices {
  Future<dynamic> fetchGetApiResponse(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? extraHeaders,
  });

  Future<dynamic> postApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? extraHeaders,
    List<UploadFile>? files,
    List<String>? allowedFileTypes,
  });

  Future<dynamic> putApiResponse(
    String url, {
    dynamic data,
    Map<String, String>? extraHeaders,
    List<UploadFile>? files,
    List<String>? allowedFileTypes,
  });

  Future<dynamic> patchApiResponse(
    String url, {
    dynamic data,
    Map<String, String>? extraHeaders,
    List<UploadFile>? files,
    List<String>? allowedFileTypes,
  });

  /// Delete data via a DELETE API
  Future<dynamic> deleteApiResponse(String url, {dynamic data});
}

