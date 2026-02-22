import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/data/response/status.dart';
import 'package:truck_mandi/ui/core/components/loading_widget.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/vehicle_ads_vm.dart';

class MyAdsViewRedesigned extends StatelessWidget {
  const MyAdsViewRedesigned({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 180.h,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'My Add',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
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
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 60.h),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      size: 60.sp,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: EdgeInsets.all(16.w),
            sliver: Consumer<VehicleAdsVM>(
              builder: (context, value, child) {
                final myAds = value.myAds;

                switch (myAds.status) {
                  case Status.notStarted:
                  case Status.loading:
                    return SliverToBoxAdapter(
                      child: Center(child: LoadingWidget()),
                    );

                  case Status.error:
                    return SliverToBoxAdapter(
                      child: _buildErrorState(
                        context,
                        myAds.message?.toString(),
                      ),
                    );

                  case Status.completed:
                    final trucks = myAds.data ?? [];
                    if (trucks.isEmpty) {
                      return SliverToBoxAdapter(
                        child: _buildEmptyState(context, 'No Ads Found'),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final truck = trucks[index];
                        return _buildModernAdCard(context, truck);
                      }, childCount: trucks.length),
                    );

                  default:
                    return SliverToBoxAdapter(child: Container());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernAdCard(BuildContext context, dynamic truck) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   SlideTransitionPage(page: OtherAdDetailView(ad: truck)),
          // );
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          children: [
            // Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  child: truck.images.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: truck.images.first,
                          width: double.infinity,
                          height: 180.h,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            height: 180.h,
                            color: Colors.grey.shade200,
                            child: Icon(Icons.broken_image, size: 50.sp),
                          ),
                        )
                      : Container(
                          height: 180.h,
                          color: Colors.grey.shade200,
                          child: Icon(Icons.image, size: 50.sp),
                        ),
                ),
                // Status Badge
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      truck.status ?? 'Active',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Details Section
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    truck.title.isNotEmpty
                        ? truck.title
                        : "No Title Avaiblable",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  // Price
                  Text(
                    "Rs. ${truck.price}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Info Row
                  Row(
                    children: [
                      if (truck.modelYear != 0) ...[
                        _buildInfoChip(
                          context,
                          icon: Icons.calendar_today,
                          label: truck.modelYear.toString(),
                        ),
                        SizedBox(width: 8.w),
                      ],
                      _buildInfoChip(
                        context,
                        icon: Icons.location_on_outlined,
                        label: truck.location,
                        isExpanded: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Action Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   SlideTransitionPage(
                          //     page: OtherAdDetailView(ad: truck),
                          //   ),
                          // );
                        },
                        icon: Icon(Icons.arrow_forward, size: 16.sp),
                        label: Text('View Details'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    bool isExpanded = false,
  }) {
    Widget chip = Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: Colors.grey.shade700),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

    return isExpanded ? Expanded(child: chip) : chip;
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80.sp,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String? message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80.sp, color: Colors.red.shade300),
            SizedBox(height: 16.h),
            Text(
              message ?? "An error occurred",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Similar redesigned widget for Favorite Ads
class FavAdsViewRedesigned extends StatelessWidget {
  const FavAdsViewRedesigned({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 180.h,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.red,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Saved Ads",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.red, AppColors.red.withOpacity(0.8)],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 60.h),
                    child: Icon(
                      Icons.favorite,
                      size: 60.sp,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: EdgeInsets.all(16.w),
            sliver: Consumer<VehicleAdsVM>(
              builder: (context, value, child) {
                final myFavAds = value.myFavAds;

                switch (myFavAds.status) {
                  case Status.notStarted:
                  case Status.loading:
                    return SliverToBoxAdapter(
                      child: Center(child: LoadingWidget()),
                    );

                  case Status.error:
                    return SliverToBoxAdapter(
                      child: _buildErrorState(
                        context,
                        myFavAds.message?.toString(),
                      ),
                    );

                  case Status.completed:
                    final trucks = myFavAds.data ?? [];
                    if (trucks.isEmpty) {
                      return SliverToBoxAdapter(
                        child: _buildEmptyState(
                          context,
                          "No Favourite ads found.",
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final truck = trucks[index];
                        return _buildModernAdCard(context, truck);
                      }, childCount: trucks.length),
                    );

                  default:
                    return SliverToBoxAdapter(child: Container());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernAdCard(BuildContext context, dynamic truck) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          // SlideTransitionPage(page: OtherAdDetailView(ad: truck)),
          // );
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          children: [
            // Image Section with Heart
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  child: truck.images.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: truck.images.first,
                          width: double.infinity,
                          height: 180.h,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            height: 180.h,
                            color: Colors.grey.shade200,
                            child: Icon(Icons.broken_image, size: 50.sp),
                          ),
                        )
                      : Container(
                          height: 180.h,
                          color: Colors.grey.shade200,
                          child: Icon(Icons.image, size: 50.sp),
                        ),
                ),
                // Heart Badge
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.red,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),

            // Details Section (same as MyAds)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truck.title.isNotEmpty
                        ? truck.title
                        : "No Title Avaiblable",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Rs. ${truck.price}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      if (truck.modelYear != 0) ...[
                        _buildInfoChip(
                          context,
                          icon: Icons.calendar_today,
                          label: truck.modelYear.toString(),
                        ),
                        SizedBox(width: 8.w),
                      ],
                      _buildInfoChip(
                        context,
                        icon: Icons.location_on_outlined,
                        label: truck.location,
                        isExpanded: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   SlideTransitionPage(
                          //     page: OtherAdDetailView(ad: truck),
                          //   ),
                          // );
                        },
                        icon: Icon(Icons.arrow_forward, size: 16.sp),
                        label: Text('View Details'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    bool isExpanded = false,
  }) {
    Widget chip = Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: Colors.grey.shade700),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

    return isExpanded ? Expanded(child: chip) : chip;
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80.sp,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String? message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80.sp, color: Colors.red.shade300),
            SizedBox(height: 16.h),
            Text(
              message ?? "An error occurred",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
