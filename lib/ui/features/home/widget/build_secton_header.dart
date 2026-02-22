import 'package:flutter/material.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/ui/core/theme/theme_text.dart';

Widget buildSectionHeader(
  BuildContext context, {
  required String title,
  required VoidCallback onViewAllPressed,
  bool hasViewAll = true,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Themetext.blackBoldText.copyWith(fontSize: 20)),
        if (hasViewAll)
          InkWell(
            onTap: onViewAllPressed,
            child: Text(
              'View All',
              style: Themetext.blackBoldText.copyWith(color: AppColors.primary),
            ),
          ),
      ],
    ),
  );
}

Widget buildSparePartsList() {
  final spareParts = [
    'Body Part',
    'Crush Plant',
    'Hydraulic Pump',
    'Cabin',
    'Hydraulic Jack',
    'Excavator Boom',
    'Engine',
    'Boozer\nCompressor',
    'Loader Bucket',
  ];

  // Group spare parts into rows of three
  List<List<String>> groupedParts = [];
  for (int i = 0; i < spareParts.length; i += 3) {
    groupedParts.add(
      spareParts.sublist(
        i,
        (i + 3) > spareParts.length ? spareParts.length : i + 3,
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedParts.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: row.map((part) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.circle, size: 8, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(part, style: const TextStyle(fontSize: 14)),
                ],
              ),
            );
          }).toList(),
        );
      }).toList(),
    ),
  );
}

Widget buildBudgetList() {
  final spareParts = [
    'under 5 lakh',
    '5 - 1.5 crore',
    '10 - 20 lakh',
    '30-40 lakh',
    '40 - 50 lakh',
    '50 - 60 crore',
    '80 lakh-1 crore',
    '1 - 1.5 crore',
    '1.5 2 crore',
  ];

  // Group spare parts into rows of three
  List<List<String>> groupedParts = [];
  for (int i = 0; i < spareParts.length; i += 3) {
    groupedParts.add(
      spareParts.sublist(
        i,
        (i + 3) > spareParts.length ? spareParts.length : i + 3,
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedParts.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: row.map((part) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle, size: 8, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(part, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    ),
  );
}

Widget buildModelList() {
  final spareParts = [
    'Corolla',
    'Civic',
    'City',
    'Camry',
    'Vitz',
    'Swift',
    'Sportage',
    'Fortuner',
    'Hilux',
    'Land\nCruiser',
    'Prado',
    'Mustang',
    'Accord',
    'Altis',
    'Mehran',
    'Cultus',
  ];

  // Group spare parts into rows of three
  List<List<String>> groupedParts = [];
  for (int i = 0; i < spareParts.length; i += 4) {
    groupedParts.add(
      spareParts.sublist(
        i,
        (i + 4) > spareParts.length ? spareParts.length : i + 4,
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedParts.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: row.map((part) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.circle, size: 8, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(part, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    ),
  );
}

Widget buildCityList() {
  final spareParts = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Rawalpindi',
    'Peshawar',
    'Quetta',
    'Faisalabad',
    'Multan',
    'Gujranwala',
    'Sialkot',
    'Hyderabad',
    'Sukkur',
    'Bahawalpur',
    'Sargodha',
    'Abbottabad',
  ];

  // Group spare parts into rows of three
  List<List<String>> groupedParts = [];
  for (int i = 0; i < spareParts.length; i += 4) {
    groupedParts.add(
      spareParts.sublist(
        i,
        (i + 4) > spareParts.length ? spareParts.length : i + 4,
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedParts.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: row.map((part) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.circle, size: 8, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(part, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    ),
  );
}

Widget buildPaktruckBrandsList(BuildContext context) {
  final brands = [
    {'name': 'Hino', 'icon': 'assets/images/hino.png'},
    {'name': 'Isuzu', 'icon': 'assets/images/isuzu.png'},
    {'name': 'Tata', 'icon': 'assets/images/tata.png'},
    {'name': 'Sinotruk', 'icon': 'assets/images/sinotruk.png'},
    {'name': 'Kamaz', 'icon': 'assets/images/kamaz.png'},
    {'name': 'JAC', 'icon': 'assets/images/jac.png'},
    {'name': 'Scania', 'icon': 'assets/images/scania.png'},
    {'name': 'Kamaz', 'icon': 'assets/images/kamaz.png'},
    {'name': 'FAW Pakistan', 'icon': 'assets/images/faw.png'},
  ];

  // Group brands into rows of three
  List<List<Map<String, String>>> groupedBrands = [];
  for (int i = 0; i < brands.length; i += 3) {
    groupedBrands.add(
      brands.sublist(i, (i + 3) > brands.length ? brands.length : i + 3),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedBrands.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: row.map((brand) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        brand['icon']!,
                        height: 30, // Adjust the size of the icon
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: context.mediaQueryWidth / 6,
                        child: Text(
                          brand['name']!,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    ),
  );
}
