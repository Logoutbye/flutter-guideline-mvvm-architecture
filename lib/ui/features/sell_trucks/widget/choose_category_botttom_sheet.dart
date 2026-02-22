import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';

Future<void> chooseCategoryBottomSheet({
  required BuildContext context,
  required String title,
  required Map<String, List<String>> data,
  required String selectedParent,

  required ValueChanged<String> onItemSelected,
  bool isSearchEnabled = false,
  String? initialSelectedValue,
}) async {
  String? selectedChild;
  if (initialSelectedValue != null && initialSelectedValue.contains(' - ')) {
    final parts = initialSelectedValue.split(' - ');
    if (parts.length == 2 && data[selectedParent]?.contains(parts[1]) == true) {
      selectedChild = parts[1];
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                // Child Categories
                if (data.containsKey(selectedParent))
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: data[selectedParent]!.map((child) {
                        final isSelected = selectedChild == child;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedChild = child; // Store English key
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  child, // Display English directly
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.black,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (isSelected)
                                  SvgPicture.asset(
                                    "assets/svg/check.svg",
                                    color: AppColors.primary,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                else
                  const Center(
                    child: Text(
                      "No subcategories available",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                // Confirm Button
                const SizedBox(height: 16),
                Center(
                  child: RoundButton(
                    title: "Confirm", // Always English
                    onPress: () {
                      if (selectedChild != null) {
                        onItemSelected(
                          "$selectedParent - $selectedChild",
                        ); // Return English keys
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
