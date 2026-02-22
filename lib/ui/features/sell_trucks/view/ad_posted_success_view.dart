import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/domain/model/favorite_ads_model.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/dashboard/view/dashboard.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view/choose_what_you_want_to_sell__sheet.dart';

class AdPostedSuccessView extends StatefulWidget {
  final FavoriteAdsModel ad;
  const AdPostedSuccessView({super.key, required this.ad});

  @override
  State<AdPostedSuccessView> createState() => _AdPostedSuccessViewState();
}

class _AdPostedSuccessViewState extends State<AdPostedSuccessView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToDashboard() {
    MyNavigationService.pushAndRemoveAll(Dashboard());
  }

  void _addMore() {
    ChooseWhatYouWantToSellSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        _goToDashboard();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background Circle Decoration
            Positioned(
              bottom: -150.sp,
              right: -100.sp,
              child: Container(
                height: 300.sp,
                width: 300.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffe9eeeb),
                ),
              ),
            ),
            Positioned(
              top: -80.sp,
              left: -100.sp,
              child: Container(
                height: 200.sp,
                width: 200.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfff3faf6),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.black),
                onPressed: () =>
                    MyNavigationService.pushAndRemoveAll(Dashboard()),
              ),
            ),

            // Main content
            Column(
              children: [
                SizedBox(height: mediaHeight * 0.12),

                // Animated icon
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SvgPicture.asset(
                      'assets/svg/cong.svg',
                      height: 140.sp,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Success text
                Text(
                  "Ad Posted Successfully!",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12.h),

                Text(
                  "Your ad is now under review and will soon reach millions of buyers.",
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Bottom buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: RoundButton(
                          title: "View My Ad",
                          color: AppColors.primary,
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                          onPress: () {
                            // TODO: Navigate to Ad Details
                          },
                        ),
                      ),

                      SizedBox(height: 14.h),

                      SizedBox(
                        width: double.infinity,
                        child: RoundButton(
                          title: "Add More",
                          color: Colors.grey[300]!,
                          textStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                          ),
                          borderRadius: 15,
                          onPress: _addMore,
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
