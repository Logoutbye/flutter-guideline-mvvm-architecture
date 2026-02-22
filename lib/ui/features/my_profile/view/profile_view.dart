import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/core/theme/theme_text.dart';
import 'package:truck_mandi/ui/features/my_profile/view/contact_us_view.dart';
import 'package:truck_mandi/ui/features/my_profile/view/edit_profile_view.dart';
import 'package:truck_mandi/ui/features/my_profile/view/my_ads_view.dart';
import 'package:truck_mandi/ui/features/my_profile/view/my_profile_widget.dart';
import 'package:truck_mandi/ui/features/my_profile/view/show_delete_dialog.dart';
import 'package:truck_mandi/ui/features/my_profile/view/show_logout_dialog.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/vehicle_ads_vm.dart';

class ProfileViewRedesigned extends StatefulWidget {
  const ProfileViewRedesigned({super.key});

  @override
  State<ProfileViewRedesigned> createState() => _ProfileViewRedesignedState();
}

class _ProfileViewRedesignedState extends State<ProfileViewRedesigned> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<VehicleAdsVM>().fetchMyAds();
      context.read<VehicleAdsVM>().fetchMyFavAds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 100.h,
            floating: false,
            pinned: false,
            backgroundColor: AppColors.primary,

            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.h),
                    child: MyProfileConsumerWidgetRedesigned(),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // Quick Actions Card
                  _buildQuickActionsCard(context),

                  SizedBox(height: 16.h),

                  // Statistics Card
                  _buildStatisticsCard(context),

                  SizedBox(height: 16.h),

                  // Settings Section
                  _buildSettingsSection(context),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
            'Quick Actions',
            style: Themetext.headline.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickActionItem(
                context,
                icon: 'assets/svg/edit.svg',
                label: 'Edit Profile',
                onTap: () {
                  MyNavigationService.push(EditProfileViewRedesigned());
                },
                // Navigator.pushNamed(context, RoutesName.editProfile),
                // onTap: () => Navigator.pushNamed(context, RoutesName.editProfile),
              ),
              _buildQuickActionItem(
                context,
                icon: 'assets/svg/myads.svg',
                label: 'My Ads',
                onTap: () {
                  MyNavigationService.push(MyAdsViewRedesigned());
                },
              ),
              _buildQuickActionItem(
                context,
                icon: 'assets/svg/heart.svg',
                label: 'Saved Ads',
                onTap: () {
                  // Navigate to saved ads
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(
    BuildContext context, {
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            SvgPicture.asset(icon, height: 24.h, color: AppColors.primary),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
      child: Consumer<VehicleAdsVM>(
        builder: (context, viewModel, child) {
          final myAdsCount = viewModel.myAds.data?.length ?? 0;
          final favAdsCount = viewModel.myFavAds.data?.length ?? 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                count: myAdsCount.toString(),
                label: 'TotalAds',
                icon: Icons.inventory_2_outlined,
                color: AppColors.primary,
              ),
              Container(height: 50.h, width: 1, color: Colors.grey.shade300),
              _buildStatItem(
                context,
                count: favAdsCount.toString(),
                label: 'Favorites',
                icon: Icons.favorite_outline,
                color: AppColors.red,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String count,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          count,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12),
            child: Text(
              'Settings',
              style: Themetext.headline.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          _buildSettingsItem(
            context,
            icon: 'assets/svg/contact_us.svg',
            title: 'Contact Us',
            onTap: () {
              // Navigate to contact us
              MyNavigationService.push(ContactUsViewRedesigned());
            },
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            icon: 'assets/svg/bucket.svg',
            title: 'Delete Account',
            titleColor: AppColors.red,
            onTap: () {
              // Show delete dialog
              showDeleteDialog(context);
            },
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            icon: 'assets/svg/logout.svg',
            title: 'logout',
            titleColor: AppColors.red,
            onTap: () {
              // Show logout dialog
              showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
    Color? titleColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: (titleColor ?? AppColors.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(
                icon,
                height: 20.h,
                color: titleColor ?? AppColors.primary,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Divider(height: 1, color: Colors.grey.shade200),
    );
  }
}
