import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:truck_mandi/data/response/status.dart';
import 'package:truck_mandi/domain/model/user.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/my_profile/view/user_image_avatar_widget.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/my_profile_vm.dart';

class MyProfileConsumerWidgetRedesigned extends StatefulWidget {
  final bool isOtherWidget;
  const MyProfileConsumerWidgetRedesigned({
    super.key,
    this.isOtherWidget = false,
  });

  @override
  State<MyProfileConsumerWidgetRedesigned> createState() =>
      _MyProfileConsumerWidgetRedesignedState();
}

class _MyProfileConsumerWidgetRedesignedState
    extends State<MyProfileConsumerWidgetRedesigned> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final profileViewModel = Provider.of<ProfileVM>(context, listen: false);
      profileViewModel.fetchMyProfileApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileVM>(
      builder: (BuildContext context, ProfileVM value, Widget? child) {
        final profileState = value.myProfile;
        final user = profileState.data;

        if (profileState.status == Status.loading && user == null) {
          return ShimmerLoadingWidgetRedesigned();
        }

        if (profileState.status == Status.error && user == null) {
          return Center(child: Text('Error: ${profileState.message}'));
        }

        if (user == null) {
          return Center(child: Text("User data not available"));
        }

        return widget.isOtherWidget
            ? UserProfileSecondWidgetRedesigned(user: user, isForVerify: true)
            : UserProfileWidgetRedesigned(user: user, isForVerify: false);
      },
    );
  }
}

class UserProfileWidgetRedesigned extends StatelessWidget {
  final User user;
  final bool isForVerify;

  const UserProfileWidgetRedesigned({
    super.key,
    required this.user,
    this.isForVerify = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      child: Row(
        children: [
          // Profile Image
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: UserImageAvatarWidget(
                  isForVerify: true,
                  imageUrl: user.profileImage ?? '',
                  width: 60,
                  height: 60,
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Name and Verification Badge
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        user.fullname.toString().formattedName,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    if (user.accountVerificationStatus == 'approved')
                      SvgPicture.asset('assets/svg/verified.svg', height: 20.h),
                  ],
                ),
                SizedBox(height: 4.h),

                // Member Since
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12.sp,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    SizedBox(width: 4.w),
                    Directionality(
                      textDirection:
                          Localizations.localeOf(context).languageCode == 'ur'
                          ? TextDirection.ltr
                          : TextDirection.ltr,
                      child: Text(
                        'Member Since ${user.createdAt.toString().toFormattedDate()}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileSecondWidgetRedesigned extends StatelessWidget {
  final User user;
  final bool isForVerify;

  const UserProfileSecondWidgetRedesigned({
    super.key,
    required this.user,
    this.isForVerify = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          // Profile Image with Badge
          Stack(
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
                child: UserImageAvatarWidget(
                  isForVerify: true,
                  imageUrl: user.profileImage ?? '',
                  width: 100,
                  height: 100,
                ),
              ),
              if (user.accountVerificationStatus == 'approved')
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 16.sp),
                  ),
                ),
            ],
          ),
          SizedBox(height: 20.h),

          // Name with Verification
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  user.fullname ?? 'Your Name',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (user.accountVerificationStatus == 'approved') ...[
                SizedBox(width: 8.w),
                SvgPicture.asset('assets/svg/verified.svg', height: 24.h),
              ],
            ],
          ),
          SizedBox(height: 12.h),

          // Verification Status Badge
          InkWell(
            onTap: () {
              if (!isForVerify) {
                // Navigator.pushNamed(context, RoutesName.checkVerificationScreen);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: user.accountVerificationStatus == 'approved'
                    ? Colors.green.withOpacity(0.2)
                    : AppColors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: user.accountVerificationStatus == 'approved'
                      ? Colors.green
                      : AppColors.orange,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    user.accountVerificationStatus == 'approved'
                        ? Icons.verified
                        : Icons.info_outline,
                    size: 16.sp,
                    color: user.accountVerificationStatus == 'approved'
                        ? Colors.green
                        : AppColors.orange,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    user.accountVerificationStatus == 'approved'
                        ? 'Verified Account'
                        : 'Unverified Account',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: user.accountVerificationStatus == 'approved'
                          ? Colors.green
                          : AppColors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Member Since
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14.sp,
                  color: Colors.white.withOpacity(0.9),
                ),
                SizedBox(width: 6.w),
                Text(
                  'Member Since ${user.createdAt.toString().toFormattedDate()}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerLoadingWidgetRedesigned extends StatelessWidget {
  const ShimmerLoadingWidgetRedesigned({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.3),
            highlightColor: Colors.white.withOpacity(0.5),
            child: CircleAvatar(radius: 30, backgroundColor: Colors.white),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.5),
                    child: Container(
                      height: 20.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.5),
                    child: Container(
                      height: 14.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension NameFormatter on String {
  String get formattedName {
    List<String> words = trim().split(' ');
    return words.length > 1 ? '${words[0]} ${words[1]}' : words[0];
  }
}

extension DateTimeFormatter on String {
  String toFormattedDate() {
    if (isEmpty) return "N/A";
    DateTime? date = DateTime.tryParse(this);
    if (date == null) return "Invalid Date";

    return "${date.day}, ${_getMonthName(date.month)} ${date.year}";
  }

  static String _getMonthName(int month) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return monthNames[month - 1];
  }
}
