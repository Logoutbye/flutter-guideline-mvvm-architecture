import 'package:flutter/material.dart';

class AdImageProvider with ChangeNotifier {
  final List<String> imagePaths; // List of images
  int _currentIndex = 0; // Current image index

  AdImageProvider(this.imagePaths);

  int get currentIndex => _currentIndex;
  int get totalImages => imagePaths.length;

  String get currentImage => imagePaths[_currentIndex];

  // Navigate to the previous image
  void previousImage() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  // Navigate to the next image
  void nextImage() {
    if (_currentIndex < imagePaths.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }
}
