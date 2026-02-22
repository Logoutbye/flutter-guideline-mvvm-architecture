import 'dart:io';

import 'package:truck_mandi/domain/model/favorite_ads_model.dart';
import 'package:truck_mandi/domain/model/user.dart';


abstract class AdRepository {
  Future<dynamic> createVechileAd(
    dynamic data, {
    List<File>? images,
    List<File>? videos,
  });

  Future<dynamic> updateVehicleAd(
    String adType,
    String itemId,
    Map<String, dynamic> data, {
    List<File>? images,
    List<File>? videos,
  });

  Future<dynamic> createSparePartAd(
    dynamic data, {
    List<File>? images,
    List<File>? videos,
  });

  Future<Map<String, dynamic>> updateSparePartAd(
    String adType,
    String itemId,
    Map<String, dynamic> data, {
    List<File>? images,
    List<File>? videos,
  });
  Future<List<FavoriteAdsModel>> fetchMyAds();
  Future<List<FavoriteAdsModel>> fetchMyFavAds();
  Future<Map<String, dynamic>> toggleFavAd(dynamic data);
  Future<List<FavoriteAdsModel>> getAllVehicleAds(Map<String, dynamic> filters);
  Future<User> fetchPublicProfile(String userId);
  Future<FavoriteAdsModel> fetchAdDetails(String adType, String itemId);
  Future<Map<String, dynamic>> removeAnAd(String adType, String vehicleId);
  Future<Map<String, dynamic>> markAdAsSold(String adType, String vehicleId);
  Future<List<FavoriteAdsModel>> fetchUserAds(String userId);
  Future<Map<String, dynamic>> contactUs(Map<String, dynamic> data);
  Future<dynamic> initiateChat(String adId, String adType);

  Future<dynamic> initiateCall(String adId, String adType);

}
