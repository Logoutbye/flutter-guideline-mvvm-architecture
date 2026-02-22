import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:truck_mandi/configs/utils/my_logger.dart';
import 'package:truck_mandi/data/network/app_url.dart';
import 'package:truck_mandi/data/network/base_api_services.dart';
import 'package:truck_mandi/data/network/network_api_services.dart';
import 'package:truck_mandi/domain/model/favorite_ads_model.dart';
import 'package:truck_mandi/domain/model/user.dart';

import 'ad_repository.dart';

class AdHttpApiRepository implements AdRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  @override
  Future<dynamic> createVechileAd(
    dynamic data, {
    List<File>? images,
    List<File>? videos,
  }) async {
    try {
      final List<UploadFile> uploadFiles = [];

      if (images != null) {
        uploadFiles.addAll(
          images.map((img) => UploadFile(file: img, fieldName: 'images')),
        );
      }

      if (videos != null) {
        uploadFiles.addAll(
          videos.map((vid) => UploadFile(file: vid, fieldName: 'videos')),
        );
      }

      final response = await _apiServices.postApiResponse(
        AppUrl.createVehicleAd,
        data,
        files: uploadFiles,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> createSparePartAd(
    dynamic data, {
    List<File>? images,
    List<File>? videos,
  }) async {
    try {
      final response = await _apiServices.postApiResponse(
        AppUrl.createSparePartAd,
        data,
        // mediaFiles: [...?images, ...?videos],
        // mediaFieldNames: [
        //   ...?images?.map((_) => 'images'),
        //   ...?videos?.map((_) => 'videos'),
        // ],
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<FavoriteAdsModel>> fetchMyAds() async {
    try {
      final response = await _apiServices.fetchGetApiResponse(
        AppUrl.myVehicleAds,
      );

      final List<FavoriteAdsModel> truckAds = (response['data'] as List)
          .map((json) => FavoriteAdsModel.fromJson(json))
          .toList();

      return truckAds;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<FavoriteAdsModel>> fetchMyFavAds() async {
    try {
      final response = await _apiServices.fetchGetApiResponse(
        AppUrl.myFavorite,
      );

      final List<FavoriteAdsModel> myAds = (response['data'] as List)
          .map((json) => FavoriteAdsModel.fromJson(json))
          .toList();

      return myAds;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> toggleFavAd(dynamic data) async {
    try {
      final response = await _apiServices.postApiResponse(
        AppUrl.toggleFavoriteAd,
        jsonEncode(data),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<FavoriteAdsModel>> getAllVehicleAds(
    Map<String, dynamic> filters,
  ) async {
    try {
      final queryParams = Map<String, String>.from(filters)
        ..removeWhere((key, value) => value.isEmpty);
      final url =
          '${AppUrl.allVehicleAds}?${Uri(queryParameters: queryParams).query}';
      final response = await _apiServices.fetchGetApiResponse(url);

      final List<dynamic> data = response['data'];
      return data.map((adJson) => FavoriteAdsModel.fromJson(adJson)).toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<User> fetchPublicProfile(String userId) async {
    try {
      final response = await _apiServices.fetchGetApiResponse(
        '${AppUrl.baseUrl}/users/$userId/public-profile',
      );

      return User.fromJson(response['data']);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<FavoriteAdsModel> fetchAdDetails(String adType, String itemId) async {
    try {
      final response = await _apiServices.fetchGetApiResponse(
        '${AppUrl.adDetail}/$itemId/$adType',
      );
      final FavoriteAdsModel adDetails = FavoriteAdsModel.fromJson(
        response['data'],
      );
      return adDetails;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> markAdAsSold(
    String vehicleId,
    String adType,
  ) async {
    try {
      final response = await _apiServices.putApiResponse(
        AppUrl.markAsSoldVehicle(adType, vehicleId),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> removeAnAd(String adType, String itemId) async {
    try {
      final response = await _apiServices.deleteApiResponse(
        AppUrl.removeAd(adType, itemId),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> updateVehicleAd(
    String adType,
    String itemId,
    Map<String, dynamic> data, {
    List<File>? images,
    List<File>? videos,
  }) async {
    try {
      // Extract category and subcategory
      List<String> categoryParts = data['category']?.split('-') ?? [];
      data['mainCategory'] = categoryParts.isNotEmpty
          ? categoryParts[0].trim()
          : 'Unknown Category';
      data['subCategory'] = categoryParts.length > 1
          ? categoryParts[1].trim()
          : 'General';

      List<String> existingImages = data['images'] ?? [];
      List<File> imageFiles = images ?? [];
      List<File> videoFiles = videos ?? [];

      if (imageFiles.isNotEmpty || videoFiles.isNotEmpty) {
        data['images'] = existingImages;
        return await _apiServices.postApiResponse(
          '${AppUrl.baseUrl}/vehicle-ad/update/${adType.replaceAll(" ", "")}/$itemId',
          data,
          // mediaFiles: [...imageFiles, ...videoFiles],
          // mediaFieldNames: [
          //   ...imageFiles.map((_) => 'images'),
          //   ...videoFiles.map((_) => 'videos'),
          // ],
        );
      } else {
        return await _apiServices.postApiResponse(
          '${AppUrl.baseUrl}/vehicle-ad/update/${adType.replaceAll(" ", "")}/$itemId',
          jsonEncode(data),
        );
      }
    } catch (error) {
      MyLogger.error('Error in updateVehicleAd: $error');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> updateSparePartAd(
    String adType,
    String itemId,
    Map<String, dynamic> data, {
    List<File>? images,
    List<File>? videos,
  }) async {
    try {
      List<String> categoryParts = data['category']?.split('-') ?? [];
      data['mainCategory'] = categoryParts.isNotEmpty
          ? categoryParts[0].trim()
          : 'Unknown Category';
      data['subCategory'] = categoryParts.length > 1
          ? categoryParts[1].trim()
          : 'General';

      List<String> existingImages = data['images'] ?? [];
      List<File> imageFiles = images ?? [];
      List<File> videoFiles = videos ?? [];

      if (imageFiles.isNotEmpty || videoFiles.isNotEmpty) {
        data['images'] = existingImages;
        return await _apiServices.postApiResponse(
          '${AppUrl.baseUrl}/vehicle-ad/update/${adType.replaceAll(" ", "")}/$itemId',
          data,
          // mediaFiles: [...imageFiles, ...videoFiles],
          // mediaFieldNames: [
          //   ...imageFiles.map((_) => 'images'),
          //   ...videoFiles.map((_) => 'videos'),
          // ],
        );
      } else {
        return await _apiServices.postApiResponse(
          '${AppUrl.baseUrl}/vehicle-ad/update/${adType.replaceAll(" ", "")}/$itemId',
          jsonEncode(data),
        );
      }
    } catch (error) {
      MyLogger.error('Error in updateSparePartAd: $error');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> contactUs(Map<String, dynamic> data) async {
    try {
      final response = await _apiServices.postApiResponse(
        AppUrl.submitContactRequest,
        jsonEncode(data),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<FavoriteAdsModel>> fetchUserAds(String userId) async {
    try {
      final response = await _apiServices.fetchGetApiResponse(
        '${AppUrl.baseUrl}/users/shops/$userId/ads',
      );
      if (kDebugMode) {
        print('fetchUserAds Response: $response');
      }
      final List<dynamic> vehicleAds = response['data']['vehicleAds'] ?? [];
      final List<dynamic> sparePartAds = response['data']['sparePartAds'] ?? [];
      final List<FavoriteAdsModel> ads = [
        ...vehicleAds.map((adJson) => FavoriteAdsModel.fromJson(adJson)),
        ...sparePartAds.map((adJson) => FavoriteAdsModel.fromJson(adJson)),
      ];
      if (kDebugMode) {
        print('Parsed Ads: $ads');
      }
      return ads;
    } catch (error) {
      if (kDebugMode) {
        print('fetchUserAds Error: $error');
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> initiateChat(String adId, String adType) async {
    try {
      final response = await _apiServices.postApiResponse(
        '${AppUrl.baseUrl}/sparepart-ad/chat/$adId/$adType',
        jsonEncode({}),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> initiateCall(String adId, String adType) async {
    try {
      final response = await _apiServices.postApiResponse(
        '${AppUrl.baseUrl}/sparepart-ad/call/$adId/$adType',
        jsonEncode({}),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
