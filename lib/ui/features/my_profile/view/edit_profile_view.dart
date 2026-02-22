import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/data/response/status.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/my_profile/view/custom_text_filed.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/edit_profile_vm.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/my_profile_vm.dart';

class EditProfileViewRedesigned extends StatefulWidget {
  const EditProfileViewRedesigned({super.key});

  @override
  State<EditProfileViewRedesigned> createState() =>
      _EditProfileViewRedesignedState();
}

class _EditProfileViewRedesignedState extends State<EditProfileViewRedesigned> {
  @override
  void initState() {
    super.initState();
    final profileViewModel = Provider.of<ProfileVM>(context, listen: false);
    final editProfileViewModel = Provider.of<EditProfileVM>(
      context,
      listen: false,
    );

    Future.microtask(() {
      if (profileViewModel.myProfile.status == Status.notStarted ||
          profileViewModel.myProfile.status == Status.loading) {
        profileViewModel.fetchMyProfileApi().then((_) {
          final user = profileViewModel.myProfile.data;
          if (user != null) {
            editProfileViewModel.setProfileData(user);
          }
        });
      } else if (profileViewModel.myProfile.status == Status.completed) {
        final user = profileViewModel.myProfile.data;
        if (user != null) {
          editProfileViewModel.setProfileData(user);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final editProfileViewModel = Provider.of<EditProfileVM>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text('Edit Profile'),
      ),
      backgroundColor: AppColors.greyColor,
      body: Consumer<ProfileVM>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.myProfile.status == Status.loading) {
            return Center(child: CircularProgressIndicator());
          }

          final user = value.myProfile.data;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildProfileImagePickerRedesigned(
                    context,
                    user?.profileImage ?? '',
                  ),
                  SizedBox(height: 16.h),

                  // Personal Information Card
                  _buildSectionCard(
                    context,
                    title: 'Personal Information',
                    children: [
                      _buildInputField(
                        context,
                        label: "Full Name",
                        hint: "Enter your name",
                        controller: editProfileViewModel.nameController,
                        icon: Icons.person_outline,
                      ),
                      SizedBox(height: 16.h),
                      _buildInputField(
                        context,
                        label: "Email Address",
                        hint: "Enter your email address",
                        controller: editProfileViewModel.emailAddressController,
                        icon: Icons.email_outlined,
                      ),
                      SizedBox(height: 16.h),
                      _buildInputField(
                        context,
                        label: "Phone number",
                        hint: "Enter Your Phone No",
                        controller: editProfileViewModel.phoneNoController,
                        icon: Icons.phone_outlined,
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  // Location Information Card
                  _buildSectionCard(
                    context,
                    title: 'Location Information',
                    children: [
                      _buildInputField(
                        context,
                        label: 'Country',
                        hint: 'Enter your Country',
                        controller: editProfileViewModel.countryController,
                        icon: Icons.public_outlined,
                      ),
                      SizedBox(height: 16.h),
                      _buildInputField(
                        context,
                        label: 'City',
                        hint: 'Enter Your City',
                        controller: editProfileViewModel.cityController,
                        icon: Icons.location_city_outlined,
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<EditProfileVM>(
                        builder: (context, value, child) {
                          return RoundButton(
                            loading: value.loading,

                            textStyle: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            color: AppColors.primary,
                            title: 'Save Changes',
                            onPress: () {
                              if (editProfileViewModel.validateInputs(
                                context,
                              )) {
                                value.submitData(context);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 20.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18.sp, color: AppColors.primary),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          hintText: hint,
          controller: controller,
          color: AppColors.greyColor,
          borderColor: Colors.transparent,
        ),
      ],
    );
  }
}

Widget buildProfileImagePickerRedesigned(
  BuildContext context,
  String networkImage,
) {
  final viewModel = Provider.of<EditProfileVM>(context, listen: false);

  Future<void> showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Choose Image',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildImageSourceOption(
                    context,
                    icon: Icons.camera_alt,
                    title: 'Take a photo',
                    color: AppColors.primary,
                    onTap: () async {
                      Navigator.pop(context);
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (pickedFile != null) {
                        viewModel.setProfileImage(File(pickedFile.path));
                      }
                    },
                  ),
                  _buildImageSourceOption(
                    context,
                    icon: Icons.photo_library,
                    title: 'Choose From Gallery',
                    color: AppColors.orange,
                    onTap: () async {
                      Navigator.pop(context);
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        viewModel.setProfileImage(File(pickedFile.path));
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  return Consumer<EditProfileVM>(
    builder: (_, vm, __) {
      final image = vm.profileImage;

      return Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 60.r,
                backgroundColor: Colors.white,
                backgroundImage: image != null
                    ? FileImage(image)
                    : (networkImage.isNotEmpty
                              ? NetworkImage(networkImage)
                              : null)
                          as ImageProvider?,
                child: (image == null && networkImage.isEmpty)
                    ? Icon(Icons.person, size: 60.sp, color: Colors.grey)
                    : null,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: showImageSourceActionSheet,
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildImageSourceOption(
  BuildContext context, {
  required IconData icon,
  required String title,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}
