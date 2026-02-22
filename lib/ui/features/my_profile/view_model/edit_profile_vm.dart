import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/data/network/base_api_services.dart';
import 'package:truck_mandi/data/repository/profile_api/profile_http_api_repository.dart';
import 'package:truck_mandi/data/repository/profile_api/profile_repository.dart';
import 'package:truck_mandi/domain/model/user.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/my_profile_vm.dart';

class EditProfileVM extends ChangeNotifier {
  final ProfileRepository profileRepository = ProfileHttpApiRepository();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  File? profileImage;

  // Method to pre-fill controllers with fetched user data
  void setProfileData(User user) {
    nameController.text = user.fullname ?? '';
    emailAddressController.text = user.email ?? '';
    phoneNoController.text = user.phone;
    countryController.text = user.country ?? '';
    cityController.text = user.city ?? '';
    notifyListeners();
  }

  void setProfileImage(File? image) {
    profileImage = image;
    notifyListeners();
  }

  void clearAll() {
    profileImage = null;
    nameController.clear();
    emailAddressController.clear();
    phoneNoController.clear();
    countryController.clear();
    cityController.clear();
    notifyListeners(); // Notify UI of state changes
  }

  bool validateInputs(BuildContext context) {
    return true;
  }

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> submitData(BuildContext context) async {
    setLoading(true);
    try {
      var data = {
        if (emailAddressController.text.isNotEmpty)
          'email': emailAddressController.text.trim(),
        if (phoneNoController.text.isNotEmpty)
          'phone': phoneNoController.text.trim(),
        if (nameController.text.isNotEmpty)
          'fullname': nameController.text.trim(),
        if (countryController.text.isNotEmpty)
          'country': countryController.text.trim(),
        if (cityController.text.isNotEmpty) 'city': cityController.text.trim(),
      };

      await profileRepository.editProfile(data, [
        if (profileImage != null)
          UploadFile(file: profileImage!, fieldName: 'profileImage'),
      ]);

      setLoading(false);
      Navigator.pop(context);
      Utils.toastMessage('Profile Updated Successfully.');
      Provider.of<ProfileVM>(context, listen: false).fetchMyProfileApi();
    } catch (error) {
      Utils.flushBarErrorMessage(
        'Failed to Update Profile. Please try again.',
        context,
      );
      setLoading(false);
    }
  }
}
