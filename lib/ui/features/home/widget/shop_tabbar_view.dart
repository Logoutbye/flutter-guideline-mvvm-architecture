import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:truck_mandi/configs/utils/extensions.dart';

Widget buildTwoRowHorizontalList(BuildContext context) {
  final row1Items = [
    {
      'image': 'assets/remove/truck.png',
      'shop_name': 'Dumper Truck',
      'location': 'Islamabad',
    },
    {
      'image': 'assets/remove/truck_1.png',
      'shop_name': 'Automatic Truck',
      'location': 'Lahore',
    },
    {
      'image': 'assets/images/remove_me1.png',
      'shop_name': 'Box Truck',
      'location': 'Karachi',
    },
  ];

  final row2Items = [
    {
      'image': 'assets/remove/truck_1.png',
      'shop_name': 'Automatic Truck',
      'location': 'Lahore',
    },
    {
      'image': 'assets/remove/truck.png',
      'shop_name': 'Dumper Truck',
      'location': 'Islamabad',
    },
    {
      'image': 'assets/images/remove_me2.png',
      'shop_name': 'Box Truck',
      'location': 'Karachi',
    },
  ];

  return Column(
    children: [
      SizedBox(height: context.mediaQueryHeight / 75),
      SizedBox(
        height: context.mediaQueryHeight / 5.2,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: row1Items.length,
          itemBuilder: (context, index) {
            final item = row1Items[index];
            return _buildListItem(context, item);
          },
        ),
      ),
      SizedBox(height: context.mediaQueryHeight / 50),
      SizedBox(
        height: context.mediaQueryHeight / 5.2,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: row2Items.length,
          itemBuilder: (context, index) {
            final item = row2Items[index];
            return _buildListItem(context, item);
          },
        ),
      ),
    ],
  );
}

Widget _buildListItem(BuildContext context, Map<String, String> item) {
  final cardWidth = MediaQuery.of(context).size.width * 0.45;

  final imageHeight = context.mediaQueryHeight / 4.5 * 0.5;

  return Container(
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
              if (item['shop_name'] != null && item['shop_name']!.isNotEmpty)
                SizedBox(height: context.mediaQueryHeight / 130),
              if (item['shop_name'] != null && item['shop_name']!.isNotEmpty)
                Text(
                  item['shop_name']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (item['shop_name'] != null && item['shop_name']!.isNotEmpty)
                SizedBox(height: context.mediaQueryHeight / 100),
              if (item['location'] != null && item['location']!.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (item['location'] != null &&
                        item['location']!.isNotEmpty)
                      Row(
                        children: [
                          SvgPicture.asset('assets/svg/location.svg'),
                          SizedBox(width: 8),
                          Text(
                            item['location']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
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
