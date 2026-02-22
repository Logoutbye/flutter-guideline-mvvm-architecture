import 'package:flutter/material.dart';
import 'package:truck_mandi/configs/utils/my_logger.dart';
import 'package:truck_mandi/data/repository/ads_api/ad_http_api_repository.dart';
import 'package:truck_mandi/data/repository/ads_api/ad_repository.dart';
import 'package:truck_mandi/data/response/api_response.dart';
import 'package:truck_mandi/data/response/status.dart';
import 'package:truck_mandi/domain/model/favorite_ads_model.dart';
import 'package:truck_mandi/domain/model/user.dart';

class VehicleAdsVM with ChangeNotifier {
  final AdRepository adRepository = AdHttpApiRepository();

  ApiResponse<List<FavoriteAdsModel>> vehicleAds = ApiResponse.notStarted();

  ApiResponse<List<FavoriteAdsModel>> myFavAds = ApiResponse.notStarted();
  ApiResponse<List<FavoriteAdsModel>> myAds = ApiResponse.notStarted();
  ApiResponse<FavoriteAdsModel> adsDetails = ApiResponse.notStarted();

  ApiResponse<User> userProfile = ApiResponse.notStarted();
  ApiResponse<List<FavoriteAdsModel>> userAds = ApiResponse.notStarted();

  setVehicleAds(ApiResponse<List<FavoriteAdsModel>> response) {
    vehicleAds = response;
    notifyListeners();
  }

  setUserProfile(ApiResponse<User> response) {
    userProfile = response;
    notifyListeners();
  }

  setUserAds(ApiResponse<List<FavoriteAdsModel>> response) {
    userAds = response;
    notifyListeners();
  }

  Future<void> fetchVehicleAdsApi(Map<String, dynamic> filters) async {
    if (vehicleAds.data == null) {
      setVehicleAds(ApiResponse.loading());
    }
    try {
      final ads = await adRepository.getAllVehicleAds(filters);
      final unsoldAds = ads.where((ad) => ad.sold == false).toList();
      setVehicleAds(ApiResponse.completed(unsoldAds));
    } catch (error) {
      setVehicleAds(ApiResponse.error(error.toString()));
    }
  }

  List<FavoriteAdsModel> filterAdsByCategory(String category) {
    if (category.isEmpty) {
      return vehicleAds.data!.toList();
    }
    if (vehicleAds.status == Status.completed) {
      return vehicleAds.data!.where((ad) => ad.category == category).toList();
    }
    return [];
  }

  List<FavoriteAdsModel> filterAdsBySubCategory(String subCategory) {
    if (vehicleAds.status == Status.completed) {
      return vehicleAds.data!
          .where((ad) => ad.subCategory == subCategory)
          .toList();
    }
    return [];
  }

  List<FavoriteAdsModel> filterAdsByImported() {
    if (vehicleAds.status == Status.completed) {
      final importedVehicles = vehicleAds.data!
          .where((ad) => ad.localOrImported == 'Imported')
          .toList();

      return importedVehicles;
    }
    return [];
  }

  Future<void> fetchUserProfile(String userId) async {
    if (userProfile.data != null) {
      setUserProfile(ApiResponse.loading());
    }
    try {
      final user = await adRepository.fetchPublicProfile(userId);
      setUserProfile(ApiResponse.completed(user));
    } catch (error) {
      setUserProfile(ApiResponse.error(error.toString()));
    }
  }

  setMyAds(ApiResponse<List<FavoriteAdsModel>> response) {
    myAds = response;
    notifyListeners();
  }

  Future<void> fetchMyAds() async {
    if (myAds.data == null) setMyAds(ApiResponse.loading());

    try {
      final List<FavoriteAdsModel> ads = await adRepository.fetchMyAds();
      setMyAds(ApiResponse.completed(ads));
    } catch (error) {
      setMyAds(ApiResponse.error(error.toString()));
    }
  }

  setAdDetails(ApiResponse<FavoriteAdsModel> response) {
    adsDetails = response;
    notifyListeners();
  }

  Future<void> fetchAdDetails(String itemId, String adType) async {
    setAdDetails(ApiResponse.loading());

    try {
      final FavoriteAdsModel ads = await adRepository.fetchAdDetails(
        itemId,
        adType.replaceAll(' ', ''),
      );

      setAdDetails(ApiResponse.completed(ads));
    } catch (error) {
      setAdDetails(ApiResponse.error(error.toString()));
    }
  }

  setMyFavAds(ApiResponse<List<FavoriteAdsModel>> response) {
    myFavAds = response;
    notifyListeners();
  }

  Future<void> fetchMyFavAds() async {
    setMyFavAds(ApiResponse.loading());
    try {
      final List<FavoriteAdsModel> ads = await adRepository.fetchMyFavAds();
      setMyFavAds(ApiResponse.completed(ads));
    } catch (error) {
      setMyFavAds(ApiResponse.error(error.toString()));
    }
  }

  Future<void> toggleFav(
    BuildContext context,
    FavoriteAdsModel ad,
    String adType,
  ) async {
    print('object 3');

    bool isCurrentlyFav = ad.favorites.contains('userId');
    var data = {"itemId": ad.id, "adType": adType.replaceAll(' ', '')};

    // **Optimistically Update Local State**
    List<String> updatedFavorites = List.from(ad.favorites);
    if (isCurrentlyFav) {
      updatedFavorites.remove('userId');
    } else {
      updatedFavorites.add('userId');
    }

    // Create a new updated model
    FavoriteAdsModel updatedAd = ad.copyWith(favorites: updatedFavorites);

    // **Update Local State**
    _updateAdInLists(updatedAd);
    notifyListeners();

    try {
      await adRepository.toggleFavAd(data);
    } catch (error) {
      print('object ${error}');
      _updateAdInLists(ad);
      notifyListeners();
    }
  }

  void _updateAdInLists(FavoriteAdsModel updatedAd) {
    if (vehicleAds.status == Status.completed) {
      vehicleAds = ApiResponse.completed(
        vehicleAds.data!
            .map((ad) => ad.id == updatedAd.id ? updatedAd : ad)
            .toList(),
      );
      notifyListeners();
    }

    if (myFavAds.status == Status.completed) {
      myFavAds = ApiResponse.completed(
        myFavAds.data!.where((ad) => ad.id != updatedAd.id).toList(),
      );
      notifyListeners();
    }

    if (adsDetails.status == Status.completed &&
        adsDetails.data!.id == updatedAd.id) {
      adsDetails = ApiResponse.completed(updatedAd);
      notifyListeners();
    }
  }

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> removeAd(String adType, String vehicleId) async {
    try {
      setLoading(true);
      await adRepository.removeAnAd(adType, vehicleId);
      // Remove the ad from the local state
      myAds.data?.removeWhere((ad) => ad.id == vehicleId);
      setLoading(false);
    } catch (error) {
      setLoading(false);
    }
  }

  Future<void> markAdAsSold(String adType, String vehicleId) async {
    try {
      setLoading(true);
      await adRepository.markAdAsSold(adType, vehicleId);
      fetchMyAds();
      setLoading(false);
    } catch (error) {
      setLoading(false);
    }
  }

  Future<void> fetchAdById(String adId) async {
    await adRepository.fetchAdDetails(adId, 'vehicle');
  }

  Future<void> fetchUserAds(String userId) async {
    setUserAds(ApiResponse.loading());
    try {
      final ads = await adRepository.fetchUserAds(userId);
      setUserAds(ApiResponse.completed(ads));
    } catch (error) {
      setUserAds(ApiResponse.error(error.toString()));
    }
  }

  Future<void> submitContactRequest(Map<String, dynamic> data) async {
    try {
      final response = await adRepository.contactUs(data);
      // Handle the response if needed
      MyLogger.info(response['message']);
    } catch (error) {
      MyLogger.error('Error submitting contact request: $error');
    }
  }

  Future<void> initiateChatApi(String adId, String adType) async {
    try {
      await adRepository.initiateChat(adId, adType);
    } catch (error) {
      MyLogger.error('Error initiating chat: $error');
    }
  }

  Future<void> initiateCallApi(String adId, String adType) async {
    try {
      await adRepository.initiateCall(adId, adType);
    } catch (error) {
      MyLogger.error('Error initiating call: $error');
    }
  }
}
