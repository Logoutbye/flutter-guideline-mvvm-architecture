import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/core/theme/theme_text.dart';
import 'package:truck_mandi/ui/features/sell_spare_parts/view/sell_spare_parts_view.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view/sell_truck_view.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view_model/truck_view_model.dart';

class ChooseWhatYouWantToSellSheet extends StatelessWidget {
  const ChooseWhatYouWantToSellSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: AppColors.grey,
                ),
                width: 60,
              ),
              const SizedBox(height: 16),

              Text(
                "Choose what you want to sell",
                style: Themetext.headline.copyWith(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "What do you want to sell?",
                style: Themetext.headline.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.3,
                children: [
                  _SellOptionTile(
                    label: "Trucks",
                    icon: 'assets/svg/truck_sell.svg',
                    onTap: () => _openSellTruck(context, "Used Truck"),
                  ),
                  _SellOptionTile(
                    label: "Auto Parts",
                    icon: 'assets/svg/Black.svg',
                    onTap: () {
                      Navigator.pop(context);
                      MyNavigationService.push(SellSparePartsView());
                    },
                  ),
                  _SellOptionTile(
                    label: "Machinery",
                    icon: 'assets/svg/machinery_for_bottom.svg',
                    onTap: () => _openSellTruck(context, "Machinery"),
                  ),
                  _SellOptionTile(
                    label: "Buses",
                    icon: 'assets/svg/buses_for_bottom.svg',
                    onTap: () => _openSellTruck(context, "Used Bus"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const ChooseWhatYouWantToSellSheet(),
    );
  }

  void _openSellTruck(BuildContext context, String category) {
    final vm = Provider.of<TruckViewModel>(context, listen: false);
    vm.cateogryController.text = category;

    Navigator.pop(context);
    MyNavigationService.push(SellTruckView());
  }
}

class _SellOptionTile extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onTap;

  const _SellOptionTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xfff7f7f7),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, height: 32),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
