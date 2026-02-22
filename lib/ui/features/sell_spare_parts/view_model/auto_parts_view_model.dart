import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/configs/utils/my_logger.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/data/repository/ads_api/ad_http_api_repository.dart';
import 'package:truck_mandi/data/repository/ads_api/ad_repository.dart';
import 'package:truck_mandi/data/response/base_response.dart';
import 'package:truck_mandi/domain/model/favorite_ads_model.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/vehicle_ads_vm.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view/ad_posted_success_view.dart';

class AutoPartsViewModel extends ChangeNotifier {
  final AdRepository sellRepository = AdHttpApiRepository();

  AutoPartsViewModel() {
    _addErrorClearListeners();
  }
  // ------------------------pick media------------------------

  final List<Map<String, dynamic>> _media = [];
  List<Map<String, dynamic>> get media => _media;

  void addMedia(File file, String type) {
    _media.add({'file': file, 'type': type});
    notifyListeners();
  }

  void removeMedia(int index) {
    _media.removeAt(index);
    notifyListeners();
  }

  void clearMedia() {
    _media.clear();
    notifyListeners();
  }

  // ---------------------Controllers for truck info
  TextEditingController cateogryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // ---------------------- validations

  //Field-specific error messages
  Map<String, String?> _fieldErrors = {};

  Map<String, String?> get fieldErrors => _fieldErrors;

  void _addErrorClearListeners() {
    priceController.addListener(() => _clearFieldError('Price'));
    locationController.addListener(() => _clearFieldError('Location'));

    descriptionController.addListener(() => _clearFieldError('Description'));
  }

  void _clearFieldError(String fieldName) {
    if (_fieldErrors.containsKey(fieldName)) {
      _fieldErrors.remove(fieldName);
      notifyListeners();
    }
  }

  // Validation Logic
  bool validateSellTruckFields(BuildContext context) {
    _fieldErrors.clear();
    if (cateogryController.text.isEmpty) {
      _fieldErrors['Category'] = 'Category is required';
    }
    if (titleController.text.isEmpty) {
      _fieldErrors['Title'] = 'Title is required';
    }
    if (priceController.text.isEmpty) {
      _fieldErrors['Price'] = 'Price is required';
    }
    if (locationController.text.isEmpty) {
      _fieldErrors['Location'] = 'Location is required';
    }

    if (descriptionController.text.isEmpty) {
      _fieldErrors['Description'] = 'Description is required';
    } else if (descriptionController.text.length < 20) {
      Utils.flushBarErrorMessage(
        'Description must be at least 20 characters long',
        context,
      );
      _fieldErrors['Description'] =
          'Description must be at least 20 characters long';
    }

    notifyListeners();
    return _fieldErrors.isEmpty;
  }

  void clearErrors() {
    _fieldErrors.clear();
    notifyListeners();
  }

  // ----------------- api work
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> submitData(BuildContext context) async {
    setLoading(true);
    try {
      if (validateSellTruckFields(context)) {
        var data = {
          'category': cateogryController.text.trim(),
          'title': titleController.text.trim(),
          'location': locationController.text.trim(),
          // 'price': priceController.text.trim(),
          'price': priceController.text.replaceAll(',', '').trim(),

          'condition': conditionController.text.trim(),
          'description': descriptionController.text.trim(),
        };

        // Extract Images and Videos from `_media`
        List<File> selectedImages = _media
            .where((item) => item['type'] == 'image')
            .map<File>((item) => item['file'] as File)
            .toList();

        List<File> selectedVideos = _media
            .where((item) => item['type'] == 'video')
            .map<File>((item) => item['file'] as File)
            .toList();

        final response = await sellRepository.createSparePartAd(
          data,
          images: selectedImages,
          videos: selectedVideos,
        );
        BaseApiResponse baseResponse = BaseApiResponse.fromJson(response);
        // Parse the response to create FavoriteAdsModel
        var responseData = BaseApiResponse.fromJson(response);

        // Assuming the response body contains the ad data in the "data" field
        var adData = responseData.data;

        FavoriteAdsModel favoriteAd = FavoriteAdsModel(
          id: adData['_id'] ?? '',
          images: adData.containsKey('images')
              ? List<String>.from(adData['images'])
              : [],
          videos: adData.containsKey('videos')
              ? List<String>.from(adData['videos'])
              : [],
          category: adData['category'] ?? '',
          title: adData['title'] ?? '',
          location: adData['location'] ?? '',
          price: adData['price'] ?? 0,
          condition: adData['condition'] ?? '',
          description: adData['description'] ?? '',
          adType: adData['adType'] ?? '',
          postedBy: adData['postedBy'] ?? '',
          createdAt: adData['createdAt'] ?? '',
          v: adData['__v'] ?? 0,
          favorites: adData.containsKey('favorites')
              ? List<String>.from(adData['favorites'])
              : [],
          callCount: adData['callCount'] ?? 0,
          chatCount: adData['chatCount'] ?? 0,
        );

        if (context.mounted) {
          MyNavigationService.push(AdPostedSuccessView(ad: favoriteAd));

          Utils.toastMessage(baseResponse.message.toString());
        }
        clearForm();
        setLoading(false);
      }
      Provider.of<VehicleAdsVM>(
        context,
        listen: false,
      ).fetchMyAds(); // Clear errors after submission
    } catch (error) {
      Utils.toastMessage(error.toString());
      MyLogger.error('::: $error');
      setLoading(false);
    }
  }

  void clearForm() {
    priceController.clear();
    locationController.clear();
    cateogryController.clear();
    titleController.clear();
    conditionController.clear();
    descriptionController.clear();
    _media.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    cateogryController.clear();
    titleController.clear();
    priceController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
