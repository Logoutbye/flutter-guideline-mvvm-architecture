import 'package:flutter/material.dart';

class FilterVM extends ChangeNotifier {
  // Controllers for filter fields
  TextEditingController priceController = TextEditingController();
  TextEditingController priceFromController = TextEditingController();
  TextEditingController priceToController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController registeredInController = TextEditingController();
  TextEditingController modelYearController = TextEditingController();
  TextEditingController modelYearFromController = TextEditingController();
  TextEditingController modelYearToController = TextEditingController();
  TextEditingController truckMakeController = TextEditingController();
  TextEditingController conditionController = TextEditingController();

  // Price range values
  double _priceFrom = 0;
  double _priceTo = 100000000; // Default max value (10 million PKR)
  double _priceToForAutoParts = 100000; // Default max value (10 million PKR)
  double get priceFrom => _priceFrom;
  double get priceTo => _priceTo;
  double get priceToForAutoParts => _priceToForAutoParts;

  // Model year range values
  double _modelYearFrom = 1900;
  double _modelYearTo = 2025;
  double get modelYearFrom => _modelYearFrom;
  double get modelYearTo => _modelYearTo;

  // Engine Types
  Set<String> _selectedEngineTypes = {};
  Set<String> get selectedEngineTypes => _selectedEngineTypes;

  void selectEngineType(String engineType) {
    if (_selectedEngineTypes.contains(engineType)) {
      _selectedEngineTypes.remove(engineType);
    } else {
      _selectedEngineTypes.add(engineType);
    }
    notifyListeners();
  }

  // Transmissions
  Set<String> _selectedTransmissions = {};
  Set<String> get selectedTransmissions => _selectedTransmissions;

  void selectTransmission(String transmission) {
    if (_selectedTransmissions.contains(transmission)) {
      _selectedTransmissions.clear();
    } else {
      _selectedTransmissions.clear();
      _selectedTransmissions.add(transmission);
    }
    notifyListeners();
  }

  // Update price range
  void updatePriceRange(double from, double to) {
    _priceFrom = from;
    _priceTo = to;
    _priceToForAutoParts = to;
    priceFromController.text = from.toInt().toString();
    priceToController.text = to.toInt().toString();
    notifyListeners();
  }

  // Update model year range
  void updateModelYearRange(double from, double to) {
    _modelYearFrom = from;
    _modelYearTo = to;
    modelYearFromController.text = from.toInt().toString();
    modelYearToController.text = to.toInt().toString();
    modelYearController.text = '${from.toInt()} - ${to.toInt()}';
    notifyListeners();
  }

  // Remove a specific location
  void removeLocation(String location) {
    final locations = locationController.text.split(', ').toList();
    locations.remove(location.trim());
    locationController.text = locations.join(', ');
    notifyListeners();
  }

  // Remove a specific subcategory from a specific parent category
  void removeSubcategory(String parent, String subcategory) {
    final categoryEntries = categoryController.text.split(';');
    final updatedEntries = <String>[];

    for (var entry in categoryEntries) {
      if (entry.isNotEmpty) {
        final parts = entry.split(' - ');
        if (parts.length == 2) {
          final entryParent = parts[0].trim();
          final subcategories =
              parts[1].split(', ').map((s) => s.trim()).toList();
          if (entryParent == parent) {
            subcategories.remove(subcategory.trim());
            if (subcategories.isNotEmpty) {
              updatedEntries.add('$entryParent - ${subcategories.join(', ')}');
            }
          } else {
            updatedEntries.add(entry);
          }
        }
      }
    }

    if (updatedEntries.isEmpty) {
      categoryController.text = '';
    } else {
      categoryController.text = updatedEntries.join(';');
    }
    notifyListeners();
  }

  // Remove a specific category (for auto parts)
  void removeCategory(String category) {
    final categories = categoryController.text.split(', ').toList();
    categories.remove(category.trim());
    categoryController.text = categories.join(', ');
    notifyListeners();
  }
 void toggleTransmission(String transmission) {
    if (_selectedTransmissions.contains(transmission)) {
      _selectedTransmissions.remove(transmission);
    } else {
      _selectedTransmissions.add(transmission);
    }
    notifyListeners();
  }
  // Clear all filters
  void clearFilters() {
    priceController.clear();
    priceFromController.clear();
    priceToController.clear();
    _priceFrom = 0;
    _priceTo = 100000000;
    _priceToForAutoParts = 100000;
    locationController.clear();
    categoryController.clear();
    registeredInController.clear();
    modelYearController.clear();
    modelYearFromController.clear();
    modelYearToController.clear();
    conditionController.clear();
    _modelYearFrom = 1900;
    _modelYearTo = 2025;
    truckMakeController.clear();
    _selectedEngineTypes.clear();
    _selectedTransmissions.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    priceController.dispose();
    priceFromController.dispose();
    priceToController.dispose();
    locationController.dispose();
    categoryController.dispose();
    registeredInController.dispose();
    modelYearController.dispose();
    conditionController.dispose();
    modelYearFromController.dispose();
    modelYearToController.dispose();
    truckMakeController.dispose();
    super.dispose();
  }
}
