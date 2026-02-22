import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:truck_mandi/ui/core/theme/color.dart';

Future<void> showSelectionBottomSheet({
  required BuildContext context,
  required List<String> items,
  required String title,
  required String hintText,
  required ValueChanged<String> onItemSelected,
  bool isSearchEnabled = false,
  String? selectedItem,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (modalContext) {
      return _SelectionModalContent(
        items: items,
        title: title,
        hintText: hintText,
        onItemSelected: onItemSelected,
        isSearchEnabled: isSearchEnabled,
        selectedItem: selectedItem,
        islocation: false,
        translationMap: {},
      );
    },
  );
}

class _SelectionModalContent extends StatefulWidget {
  final List<String> items;
  final String title;
  final String hintText;
  final ValueChanged<String> onItemSelected;
  final bool isSearchEnabled;
  final bool islocation;
  final String? selectedItem;
  final Map<String, String> translationMap;

  const _SelectionModalContent({
    required this.items,
    required this.title,
    required this.hintText,
    required this.onItemSelected,
    required this.isSearchEnabled,
    required this.islocation,
    this.selectedItem,
    required this.translationMap,
  });

  @override
  _SelectionModalContentState createState() => _SelectionModalContentState();
}

class _SelectionModalContentState extends State<_SelectionModalContent> {
  late TextEditingController searchController;
  late List<String> filteredItems;
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredItems = List.from(widget.items);
    selectedItem =
        widget.selectedItem != null &&
            widget.items.contains(widget.selectedItem)
        ? widget.selectedItem
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (widget.isSearchEnabled) ...[
            Container(
              width: MediaQuery.of(context).size.width / 1.13,
              height: MediaQuery.of(context).size.height / 25,
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.grey),
              ),
              child: Center(
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    setState(() {
                      filteredItems = widget.items
                          .where(
                            (item) =>
                                item.toLowerCase().contains(
                                  value.toLowerCase(),
                                ) ||
                                (widget.translationMap[item]?.toLowerCase() ??
                                        '')
                                    .contains(value.toLowerCase()),
                          )
                          .toList();
                    });
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/svg/search_paktruck.svg"),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],

          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(
                      "noItemsAvailable",
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      final isSelected = selectedItem == item;
                      // Translate item for display
                      final displayItem = widget.translationMap[item] ?? item;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedItem = item; // Store English key
                            });
                            widget.onItemSelected(item); // Return English key
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    displayItem,
                                    textAlign: TextAlign.start,
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
                                ),
                                if (isSelected)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: SvgPicture.asset(
                                      "assets/svg/check.svg",
                                      height: 16,
                                      width: 16,
                                      color: AppColors.primary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
