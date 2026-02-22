import 'package:flutter/material.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/ui/features/home/view/truck_details_screen.dart';

class HorizontalList extends StatelessWidget {
  final List<Map<String, String>> items;
  final double height;
  final bool showPakTruckTag;
  final double imageHeightRatio;
  final double cardWidthRatio;

  const HorizontalList({
    super.key,
    required this.items,
    this.height = 200, // Default height for the list
    this.showPakTruckTag = false, // Whether to show "By PakTruck"
    this.imageHeightRatio = 0.5, // Ratio for image height
    this.cardWidthRatio = 0.45, // Ratio for card width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height != 200 ? height : context.mediaQueryHeight / 4.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildListItem(context, item);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Map<String, String> item) {
    final cardWidth = MediaQuery.of(context).size.width * cardWidthRatio;
    final imageHeight = height * imageHeightRatio;

    return GestureDetector(
      onTap: () {
        MyNavigationService.push(TruckDetailsScreen(truck: item));
      },
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with Rounded Borders
            if (item['image'] != null && item['image']!.isNotEmpty)
              Container(
                margin: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item['image']!,
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            // Item Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item['title'] != null && item['title']!.isNotEmpty)
                    Text(
                      item['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  if (item['title'] != null && item['title']!.isNotEmpty)
                    SizedBox(height: context.mediaQueryHeight / 75),
                  if (item['price'] != null && item['price']!.isNotEmpty)
                    Text(
                      item['price']!,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (item['price'] != null && item['price']!.isNotEmpty)
                    SizedBox(height: context.mediaQueryHeight / 75),
                  if (item['location'] != null &&
                          item['location']!.isNotEmpty ||
                      showPakTruckTag)
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (item['location'] != null &&
                              item['location']!.isNotEmpty)
                            Text(
                              item['location']!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          if (showPakTruckTag)
                            Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: AppColors.orange,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'By TruckBazaar',
                                  style: TextStyle(
                                    color: AppColors.orange,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}
