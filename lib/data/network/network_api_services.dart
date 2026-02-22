import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:truck_mandi/configs/utils/my_logger.dart';
import 'package:truck_mandi/data/app_exceptions.dart';
import 'package:truck_mandi/data/network/app_url.dart';
import 'package:truck_mandi/data/network/dialog/dialog.dart';
import 'package:truck_mandi/ui/features/splash/view_model/session_controller.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiService implements BaseApiServices {
  Future<Map<String, String>> _getHeaders({
    Map<String, String>? extraHeaders,
    bool isMultipart = false,
  }) async {
    String? token = SessionController().token;

    Map<String, String> headers = {
      if (!isMultipart) 'Content-Type': 'application/json',
      ...?extraHeaders,
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    MyLogger.debug('Request Headers: $headers');
    return headers;
  }

  @override
  Future<dynamic> fetchGetApiResponse(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? extraHeaders,
  }) async {
    MyLogger.debug('request url: $url');
    MyLogger.debug('request method: get');

    dynamic responseJson;
    try {
      AppUrl.init();

      Map<String, String> headers = await _getHeaders(
        extraHeaders: extraHeaders,
      );

      Uri uri = Uri.parse(url).replace(queryParameters: queryParams);
      MyLogger.debug('Final URI with query params: $uri');

      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 20));

      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    }

    return responseJson;
  }

  @override
  Future<dynamic> postApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? extraHeaders,
    List<UploadFile>? files,
    List<String>? allowedFileTypes,
  }) async {
    AppUrl.init();

    MyLogger.debug('request url: $url');
    MyLogger.debug('request body: $data');
    MyLogger.debug('request body type: ${data.runtimeType}');

    MyLogger.debug(
      'request method: POST ${files != null ? "Multipart" : "JSON"}',
    );

    if (files != null && files.isNotEmpty) {
      MyLogger.debug('number of files: ${files.length}');
      for (var uploadFile in files) {
        MyLogger.debug('file field name: ${uploadFile.fieldName}');
        MyLogger.debug('file path: ${uploadFile.file.path}');
        final fileExtension = uploadFile.file.path
            .split('.')
            .last
            .toLowerCase();
        MyLogger.debug('file extension: $fileExtension');
      }
    }

    dynamic responseJson;

    try {
      Map<String, String> headers = await _getHeaders(
        extraHeaders: extraHeaders,
        isMultipart: files != null && files.isNotEmpty,
      );

      if (files == null || files.isEmpty) {
        String requestBody;
        if (data is String) {
          requestBody = data;
        } else {
          requestBody = json.encode(data);
        }

        final response = await http
            .post(Uri.parse(url), headers: headers, body: requestBody)
            .timeout(const Duration(seconds: 20));

        responseJson = returnResponse(response);
      } else {
        // Multipart POST
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll(headers);

        // Add fields
        data?.forEach((key, value) {
          if (value is Map || value is List) {
            request.fields[key] = jsonEncode(value);
          } else {
            request.fields[key] = value.toString();
          }
        });

        // Attach files
        for (var uploadFile in files) {
          final file = uploadFile.file;
          final fieldName = uploadFile.fieldName;

          final fileExtension = file.path.split('.').last.toLowerCase();
          if (allowedFileTypes != null &&
              !allowedFileTypes.contains(fileExtension)) {
            throw Exception(
              'Unsupported file type: $fileExtension. Allowed types: ${allowedFileTypes.join(', ')}',
            );
          }

          var stream = http.ByteStream(file.openRead());
          var length = await file.length();
          var multipartFile = http.MultipartFile(
            fieldName,
            stream,
            length,
            filename: file.path.split('/').last,
          );
          request.files.add(multipartFile);
        }

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        responseJson = returnResponse(response);
      }
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    } catch (e) {
      throw AppException('$e');
    }

    return responseJson;
  }

  @override
  Future<dynamic> putApiResponse(
    String url, {
    Map<String, String>? extraHeaders,
    dynamic data,
    List<UploadFile>? files,
    List<String>? allowedFileTypes,
  }) async {
    AppUrl.init();

    MyLogger.debug('request url: $url');
    MyLogger.debug(
      'request method: PUT ${files != null && files.isNotEmpty ? "Multipart" : "JSON"}',
    );
    MyLogger.debug('request body: $data');
    if (files != null && files.isNotEmpty) {
      MyLogger.debug('number of files: ${files.length}');
      for (var uploadFile in files) {
        MyLogger.debug('file field name: ${uploadFile.fieldName}');
        MyLogger.debug('file path: ${uploadFile.file.path}');
        final fileExtension = uploadFile.file.path
            .split('.')
            .last
            .toLowerCase();
        MyLogger.debug('file extension: $fileExtension');
      }
    }

    dynamic responseJson;

    try {
      Map<String, String> headers = await _getHeaders(
        extraHeaders: extraHeaders,
        isMultipart: files != null && files.isNotEmpty,
      );

      if (files == null || files.isEmpty) {
        String requestBody;
        if (data is String) {
          requestBody = data;
        } else {
          requestBody = json.encode(data);
        }

        // Standard JSON PUT
        final response = await http
            .put(Uri.parse(url), headers: headers, body: requestBody)
            .timeout(const Duration(seconds: 20));

        responseJson = returnResponse(response);
      } else {
        // Multipart PUT (same as before)
        var request = http.MultipartRequest('PUT', Uri.parse(url));
        request.headers.addAll(headers);

        data?.forEach((key, value) {
          if (value is Map || value is List) {
            request.fields[key] = jsonEncode(value);
          } else {
            request.fields[key] = value.toString();
          }
        });

        for (var uploadFile in files) {
          final file = uploadFile.file;
          final fieldName = uploadFile.fieldName;

          final fileExtension = file.path.split('.').last.toLowerCase();
          if (allowedFileTypes != null &&
              !allowedFileTypes.contains(fileExtension)) {
            throw Exception(
              'Unsupported file type: $fileExtension. Allowed types: ${allowedFileTypes.join(', ')}',
            );
          }

          var stream = http.ByteStream(file.openRead());
          var length = await file.length();
          var multipartFile = http.MultipartFile(
            fieldName,
            stream,
            length,
            filename: file.path.split('/').last,
          );
          request.files.add(multipartFile);
        }

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        responseJson = returnResponse(response);
      }
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    } catch (e) {
      throw Exception('An error occurred: $e');
    }

    return responseJson;
  }

  @override
  Future<dynamic> patchApiResponse(
    String url, {
    Map<String, String>? extraHeaders,
    dynamic data,
    List<UploadFile>? files,
    List<String>? allowedFileTypes,
  }) async {
    AppUrl.init();

    MyLogger.debug('request url: $url');
    MyLogger.debug(
      'request method: PATCH ${files != null && files.isNotEmpty ? "Multipart" : "JSON"}',
    );
    MyLogger.debug(
      'request body: ${JsonEncoder.withIndent('  ').convert(data)}',
    );

    if (files != null && files.isNotEmpty) {
      MyLogger.debug('number of files: ${files.length}');
      for (var uploadFile in files) {
        MyLogger.debug('file field name: ${uploadFile.fieldName}');
        MyLogger.debug('file path: ${uploadFile.file.path}');
        final fileExtension = uploadFile.file.path
            .split('.')
            .last
            .toLowerCase();
        MyLogger.debug('file extension: $fileExtension');
      }
    }

    dynamic responseJson;

    try {
      Map<String, String> headers = await _getHeaders(
        extraHeaders: extraHeaders,
        isMultipart: files != null && files.isNotEmpty,
      );

      if (files == null || files.isEmpty) {
        String requestBody;
        if (data is String) {
          requestBody = data;
        } else {
          requestBody = json.encode(data);
        }

        // Standard JSON PATCH
        final response = await http
            .patch(Uri.parse(url), headers: headers, body: requestBody)
            .timeout(const Duration(seconds: 20));

        responseJson = returnResponse(response);
      } else {
        // Multipart PATCH
        var request = http.MultipartRequest('PATCH', Uri.parse(url));
        request.headers.addAll(headers);

        // Add fields
        data?.forEach((key, value) {
          if (value is Map || value is List) {
            request.fields[key] = jsonEncode(value);
          } else {
            request.fields[key] = value.toString();
          }
        });

        // Attach files
        for (var uploadFile in files) {
          final file = uploadFile.file;
          final fieldName = uploadFile.fieldName;

          final fileExtension = file.path.split('.').last.toLowerCase();
          if (allowedFileTypes != null &&
              !allowedFileTypes.contains(fileExtension)) {
            throw Exception(
              'Unsupported file type: $fileExtension. Allowed types: ${allowedFileTypes.join(', ')}',
            );
          }

          var stream = http.ByteStream(file.openRead());
          var length = await file.length();
          var multipartFile = http.MultipartFile(
            fieldName,
            stream,
            length,
            filename: file.path.split('/').last,
          );
          request.files.add(multipartFile);
        }

        var streamedResponse = await request.send().timeout(
          const Duration(seconds: 60), // ✅ Longer timeout for file uploads
          onTimeout: () {
            throw TimeoutException('File upload timeout');
          },
        );
        var response = await http.Response.fromStream(streamedResponse);
        responseJson = returnResponse(response);
      }
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    } catch (e) {
      throw Exception('An error occurred: $e');
    }

    return responseJson;
  }

  @override
  Future<dynamic> deleteApiResponse(String url, {dynamic data}) async {
    MyLogger.debug('request url: $url');
    MyLogger.debug('request body: $data');
    MyLogger.debug('request method: delete');

    dynamic responseJson;

    try {
      AppUrl.init();

      Map<String, String> headers = await _getHeaders();
      MyLogger.debug('Request Headers: $headers');

      // Manually encode data if not null
      final body = data != null ? jsonEncode(data) : null;

      // Make DELETE request
      Response response = await delete(
        Uri.parse(url),
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    MyLogger.info('response.statusCode ${response.statusCode}');
    MyLogger.info('response.body ${response.body}');

    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          return jsonDecode(response.body);
        } catch (e) {
          MyLogger.error('JSON decode error: $e');
          return response.body; // Or return empty map `{}`
        }

      case 400:
        throw BadRequestException(_getErrorMessage(response));

      case 401:
        final responseJson = jsonDecode(response.body);
        final errorMsg = responseJson['message'] ?? responseJson['error'] ?? '';

        if (!errorMsg.contains('Incorrect password')) {
          // If the error message indicates a login issue, show the login dialog
          showLoginRequiredDialog(reason: errorMsg);
        }

        throw BadRequestException(errorMsg);
      case 403:
        final responseJson = jsonDecode(response.body);
        final errorMsg = responseJson['message'] ?? responseJson['error'] ?? '';
        showAccountBannedDialog(reason: errorMsg);
        throw BadRequestException(errorMsg);

      case 500:
      case 404:
        throw BadRequestException(_getErrorMessage(response));

      default:
        throw FetchDataException(
          'Failed to communicate with server, Restart/Logout',
        );
    }
  }

  String _getErrorMessage(http.Response response) {
    try {
      final json = jsonDecode(response.body);
      return json['message'] ?? json['error'] ?? 'An unknown error occurred.';
    } catch (e) {
      return 'An unknown error occurred.';
    }
  }
}
