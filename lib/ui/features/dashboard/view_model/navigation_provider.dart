import 'package:flutter/foundation.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  // Update the selected index and notify listeners
  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notify all listeners to rebuild widgets
  }
}
