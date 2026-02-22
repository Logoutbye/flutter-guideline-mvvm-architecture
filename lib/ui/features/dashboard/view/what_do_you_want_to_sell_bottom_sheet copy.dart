import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/core/theme/theme_text.dart';
import 'package:truck_mandi/ui/features/sell_spare_parts/view/sell_spare_parts_view.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view/sell_truck_view.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view_model/truck_view_model.dart';

class WhatDoYouWantToSellBottomModelSheet extends StatelessWidget {
  const WhatDoYouWantToSellBottomModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          height: context.mediaQueryHeight / 3.7,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'What you want sell',
                        style: Themetext.headline.copyWith(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Its free takeless',
                        textAlign: TextAlign.center,
                        style: Themetext.headline.copyWith(
                          color: AppColors.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.mediaQueryHeight / 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        var viewModel = Provider.of<TruckViewModel>(
                          context,
                          listen: false,
                        );
                        viewModel.cateogryController.text = "Used Truck";

                        Navigator.pop(context);
                        MyNavigationService.push(SellTruckView());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFf2f2f2),
                            child: SvgPicture.asset(
                              'assets/svg/truck_sell.svg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          SizedBox(height: context.mediaQueryHeight / 75),
                          Text(
                            'Trucks',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        MyNavigationService.push(SellSparePartsView());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFf2f2f2),
                            child: SvgPicture.asset(
                              'assets/svg/Black.svg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          SizedBox(height: context.mediaQueryHeight / 75),
                          Text(
                            'Spare Part',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        var viewModel = Provider.of<TruckViewModel>(
                          context,
                          listen: false,
                        );
                        viewModel.cateogryController.text = "Machinery";

                        Navigator.pop(context);
                        MyNavigationService.push(SellTruckView());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFf2f2f2),
                            child: SvgPicture.asset(
                              'assets/svg/machinery_for_bottom.svg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          SizedBox(height: context.mediaQueryHeight / 75),
                          Text(
                            'Machinery',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        var viewModel = Provider.of<TruckViewModel>(
                          context,
                          listen: false,
                        );
                        viewModel.cateogryController.text = "Used Bus";

                        Navigator.pop(context);

                        MyNavigationService.push(SellTruckView());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFf2f2f2),
                            child: SvgPicture.asset(
                              'assets/svg/buses_for_bottom.svg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          SizedBox(height: context.mediaQueryHeight / 75),
                          Text(
                            'Buses',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16.sp,
          right: Localizations.localeOf(context).languageCode == 'ur'
              ? null
              : 16,
          left: Localizations.localeOf(context).languageCode == 'ur'
              ? 16
              : null,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xfff0f0f0),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.close,
                size: 20,
                color: AppColors.blackColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return const WhatDoYouWantToSellBottomModelSheet();
      },
    );
  }
}
