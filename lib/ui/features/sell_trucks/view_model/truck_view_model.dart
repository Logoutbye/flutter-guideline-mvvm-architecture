import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/configs/routing/slide_transition_page.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/data/repository/ads_api/ad_http_api_repository.dart';
import 'package:truck_mandi/data/repository/ads_api/ad_repository.dart';
import 'package:truck_mandi/data/response/base_response.dart';
import 'package:truck_mandi/domain/model/favorite_ads_model.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/vehicle_ads_vm.dart';
import '../view/ad_posted_success_view.dart';

class TruckViewModel extends ChangeNotifier {
  final AdRepository sellRepository = AdHttpApiRepository();

  TruckViewModel() {
    _addErrorClearListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  String _choosePlan = '';
  String get choosePlan => _choosePlan;

  final List<Map<String, dynamic>> _media = [];
  List<Map<String, dynamic>> get media => _media;

  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController cateogryController = TextEditingController();
  TextEditingController registeredInController = TextEditingController();
  TextEditingController modelYearController = TextEditingController();
  TextEditingController truckMakeController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  final Set<String> _selectedEngineTypes = {};

  Set<String> get selectedEngineTypes => _selectedEngineTypes;

  final Map<String, String?> _fieldErrors = {};

  Map<String, String?> get fieldErrors => _fieldErrors;

  String? selectedTransmission;
  String? selectedEngineType;

  void addMedia(File file, String type) {
    _media.add({'file': file, 'type': type});
    notifyListeners();
  }

  void removeMedia(int index) {
    _media.removeAt(index);
    notifyListeners();
  }

  void setPlan(String plan) {
    _choosePlan = plan;
    notifyListeners();
  }

  void selectTransmission(String transmission) {
    selectedTransmission = transmission;
    notifyListeners();
  }

  void selectEngineType(String engineType) {
    selectedEngineType = engineType;
    notifyListeners();
  }

  void initializeValues(FavoriteAdsModel ad) {
    selectedTransmission = ad.localOrImported;
    selectedEngineType = ad.engineType;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void _addErrorClearListeners() {
    priceController.addListener(() => _clearFieldError('Price'));
    locationController.addListener(() => _clearFieldError('Location'));
    cateogryController.addListener(() => _clearFieldError('Category'));
    titleController.addListener(() => _clearFieldError('Title'));
    registeredInController.addListener(() => _clearFieldError('Registered In'));
    modelYearController.addListener(() => _clearFieldError('Truck Year'));
    truckMakeController.addListener(() => _clearFieldError('Truck Make'));

    descriptionController.addListener(() => _clearFieldError('Description'));
  }

  void _clearFieldError(String fieldName) {
    if (_fieldErrors.containsKey(fieldName)) {
      _fieldErrors.remove(fieldName);
      notifyListeners();
    }
  }

  bool validateSellTruckFields(BuildContext context) {
    _fieldErrors.clear();

    if (_media.isEmpty) {
      Utils.flushBarErrorMessage('Please select one Image at least', context);
      return false;
    }

    if (priceController.text.isEmpty) {
      _fieldErrors['Price'] = 'Price is required';
      Utils.flushBarErrorMessage('Price is required', context);
    }

    if (locationController.text.isEmpty) {
      _fieldErrors['Location'] = 'Location is required';
      Utils.flushBarErrorMessage('Location is required', context);
    }
    if (cateogryController.text.isEmpty ||
        !cateogryController.text.contains(' - ')) {
      _fieldErrors['Category'] = 'Category is required';
      Utils.flushBarErrorMessage('Category is required', context);
    }
    if (titleController.text.isEmpty) {
      _fieldErrors['Title'] = 'Title is required';
      Utils.flushBarErrorMessage('Title is required', context);
    }
    if (registeredInController.text.isEmpty) {
      _fieldErrors['Registered In'] = 'Registration area is required';
    }
    if (modelYearController.text.isEmpty) {
      _fieldErrors['Truck Year'] = 'Truck year is required';
    }
    if (modelYearController.text == '0') {
      _fieldErrors['Truck Year'] = 'Truck year must not be zero';
    }
    if (truckMakeController.text.isEmpty) {
      _fieldErrors['Truck Make'] = 'Truck make is required';
    }
    if (selectedTransmission == null) {
      Utils.flushBarErrorMessage('Please select Assembly type', context);
      return false;
    }
    if (descriptionController.text.isEmpty) {
      _fieldErrors['Description'] = 'Description is required';
    } else if (descriptionController.text.length < 20) {
      Utils.flushBarErrorMessage(
        'Description must be at least 20 characters',
        context,
      );

      return false;
    }

    notifyListeners();
    return _fieldErrors.isEmpty;
  }

  void selectEngineTypes(String engineType) {
    if (_selectedEngineTypes.contains(engineType)) {
      _selectedEngineTypes.remove(engineType);
    } else {
      _selectedEngineTypes.add(engineType);
    }
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> submitData(BuildContext context) async {
    setLoading(true);
    try {
      List<String> categoryParts = cateogryController.text.split('-');

      String mainCategory = categoryParts.isNotEmpty
          ? categoryParts[0].trim()
          : 'Unknown Category';
      String subCategory = categoryParts.length > 1
          ? categoryParts[1].trim()
          : 'General';

      var truckData = {
        'title': titleController.text.trim(),
        'category': mainCategory,
        'subCategory': subCategory,
        'location': locationController.text.trim(),
        'price': priceController.text.replaceAll(',', '').trim(),
        'modelYear': modelYearController.text.trim(),
        'registeredIn': registeredInController.text.trim(),
        'make': truckMakeController.text.trim(),
        'engineType': selectedEngineType.toString(),
        'description': descriptionController.text.trim(),
        'localOrImported': selectedTransmission ?? '',
      };

      List<File> selectedImages = await Future.wait(
        _media
            .where((item) => item['type'] == 'image')
            .map((item) async => item['file'] as File),
      );

      final response = await sellRepository.createVechileAd(
        truckData,
        images: selectedImages,
      );

      BaseApiResponse baseResponse = BaseApiResponse.fromJson(response);

      var responseData = BaseApiResponse.fromJson(response);

      var adData = responseData.data;

      FavoriteAdsModel favoriteAd = FavoriteAdsModel(
        id: adData['_id'],
        images: List<String>.from(adData['images']),
        videos: List<String>.from(adData['videos']),
        category: adData['category'],
        title: adData['title'],
        subCategory: adData['subCategory'],
        location: adData['location'],
        price: adData['price'],
        modelYear: adData['modelYear'],
        registeredIn: adData['registeredIn'],
        make: adData['make'],
        engineType: adData['engineType'],
        description: adData['description'],
        localOrImported: adData['localOrImported'],
        adType: adData['adType'],
        postedBy: adData['postedBy'],
        createdAt: adData['createdAt'],
        v: adData['__v'],
        favorites: List<String>.from(adData['favorites']),
        callCount: adData['callCount'],
        chatCount: adData['chatCount'],
      );

      if (context.mounted) {
        Navigator.push(
          context,
          SlideTransitionPage(
            slideDirection: SlideDirection.top,
            page: AdPostedSuccessView(ad: favoriteAd),
          ),
        );
        Utils.toastMessage(baseResponse.message.toString());
      }

      setLoading(false);

      clearForm();
      Provider.of<VehicleAdsVM>(context, listen: false).fetchMyAds();
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setLoading(false);
    }
  }

  void clearForm() {
    priceController.clear();
    locationController.clear();
    cateogryController.clear();
    titleController.clear();
    registeredInController.clear();
    modelYearController.clear();
    truckMakeController.clear();
    descriptionController.clear();
    selectedEngineType = null;
    selectedTransmission = null;
    _media.clear();
    notifyListeners();
  }

  void clearErrors() {
    _fieldErrors.clear();
    notifyListeners();
  }

  void clearMedia() {
    _media.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    priceController.dispose();
    locationController.dispose();
    cateogryController.dispose();
    titleController.dispose();
    registeredInController.dispose();
    modelYearController.dispose();
    truckMakeController.dispose();
    descriptionController.dispose();

    super.dispose();
  }
}
