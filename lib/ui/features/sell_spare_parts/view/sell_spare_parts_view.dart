import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_mandi/configs/app_constants.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/sell_spare_parts/view_model/auto_parts_view_model.dart';
import 'package:truck_mandi/ui/features/sell_trucks/widget/show_selection_bottom_sheet.dart';
import 'package:truck_mandi/ui/features/sell_spare_parts/view/auto_media_picker.dart';
import 'package:truck_mandi/ui/core/components/custom_sell_text_field.dart';
import 'package:truck_mandi/ui/core/components/text_filed_for_description.dart';

class SellSparePartsView extends StatefulWidget {
  const SellSparePartsView({super.key});

  @override
  State<SellSparePartsView> createState() => _SellSparePartsViewState();
}

class _SellSparePartsViewState extends State<SellSparePartsView> {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<AutoPartsViewModel>(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.whiteColor,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(35.h),
            child: AppBar(
              centerTitle: true,
              surfaceTintColor: AppColors.whiteSccafold,
              leading: SizedBox(
                height: 20,
                width: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, size: 20),
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 13, right: 5),
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                autoMediaPicker(
                  context,
                  "Upload Media",
                  Provider.of<AutoPartsViewModel>(context),
                ),
                SizedBox(height: context.mediaQueryHeight / 70),
                SizedBox(height: context.mediaQueryHeight / 70),
                SizedBox(
                  height: 20.h,
                  child: Text(
                    "Auto Part Information",

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomSellTextField(
                  errorText: viewModel.fieldErrors['Title'],
                  titleText: "Title",
                  hintText: "Enter Title",
                  controller: viewModel.titleController,
                  leading: SvgPicture.asset('assets/svg/sort copy.svg'),
                ),
                // Category
                CustomSellTextField(
                  readOnly: true,
                  errorText: viewModel.fieldErrors['Category'],
                  titleText: "Category",
                  hintText: "Select Category",
                  controller: viewModel.cateogryController,
                  leading: SvgPicture.asset('assets/svg/truck_leading.svg'),
                  onTrailingTap: () {
                    showSelectionBottomSheet(
                      context: context,
                      title: "Select Category",
                      hintText: "Search by Category",
                      items: sparePartsCategories,
                      isSearchEnabled: true, // Enable search for Category
                      onItemSelected: (selectedItem) {
                        viewModel.cateogryController.text = selectedItem;
                      },
                      selectedItem: viewModel
                          .cateogryController
                          .text, // Pre-select current category
                    );
                  },
                  trailing: SvgPicture.asset(
                    height: 10.h,
                    width: 10.w, // Added for consistency
                    "assets/svg/arrow-down.svg",
                  ),
                ),

                // Location
                CustomSellTextField(
                  readOnly: true,
                  errorText: viewModel.fieldErrors['Location'],
                  titleText: "Location",
                  hintText: "Enter Location",
                  controller: viewModel.locationController,
                  leading: SvgPicture.asset(
                    'assets/svg/location.svg',
                    height: 18.h,
                  ),
                  onTrailingTap: () {
                    showSelectionBottomSheet(
                      context: context,
                      title: "Select Location",
                      hintText: "Search by Location",
                      items: pakistanCities,

                      isSearchEnabled: true,
                      onItemSelected: (selectedItem) {
                        viewModel.locationController.text = selectedItem;
                      },
                      selectedItem: viewModel
                          .locationController
                          .text, // Pre-select current location
                    );
                  },
                  trailing: SvgPicture.asset(
                    height: 10.h,
                    width: 10.w, // Added for consistency
                    "assets/svg/arrow-down.svg",
                  ),
                ),

                //  price
                CustomSellTextField(
                  errorText: viewModel.fieldErrors['Price'],
                  titleText: "Price (PKR)",
                  hintText: "Enter Price",
                  controller: viewModel.priceController,
                  onChanged: (value) {
                    // Remove invalid characters and enforce a limit
                    String sanitizedValue = value.replaceAll(
                      RegExp(r'[.,]'),
                      '',
                    );
                    if (sanitizedValue.length > 12) {
                      sanitizedValue = sanitizedValue.substring(
                        0,
                        12,
                      ); // Limit to 10 digits
                    }
                    viewModel.priceController.text = sanitizedValue;
                  },
                  leading: SvgPicture.asset(
                    'assets/svg/price_feild.svg',
                    height: 18.h,
                  ),
                ),

                //  conditon
                CustomSellTextField(
                  isRadio: true,
                  radioWidget: Row(
                    children: [
                      // Radio button for "New"
                      Row(
                        children: [
                          Radio<String>(
                            fillColor: MaterialStateProperty.all(
                              AppColors.primary,
                            ),
                            value: 'New',
                            groupValue: viewModel.conditionController.text,
                            onChanged: (value) {
                              viewModel.conditionController.text = value!;
                              setState(() {}); // Update the UI
                            },
                          ),
                          Text(
                            'New',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16), // Spacing between radio buttons
                      // Radio button for "Used"
                      Row(
                        children: [
                          Radio<String>(
                            fillColor: MaterialStateProperty.all(
                              AppColors.primary,
                            ),
                            value: 'Used',
                            groupValue: viewModel.conditionController.text,
                            onChanged: (value) {
                              viewModel.conditionController.text = value!;
                              setState(() {}); // Update the UI
                            },
                          ),
                          Text(
                            'Used',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  errorText: viewModel.fieldErrors['Condition'],
                  titleText: "Condition",
                  hintText: "Enter Condition",
                  controller: viewModel.conditionController,
                  leading: SvgPicture.asset(
                    'assets/svg/condition.svg',
                    height: 18.h,
                  ),
                  trailing: InkWell(
                    onTap: () {
                      // Add any additional functionality here
                    },
                    child: Image.asset('assets/images/more.png'),
                  ),
                ),
                SizedBox(height: context.mediaQueryHeight / 50),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 145.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFieldForDescription(
                    errorText: viewModel.fieldErrors['Description'],
                    maxLines: 4,
                    minLines: 4,
                    titleText: "Description",
                    hintText: "Enter Description",
                    controller: viewModel.descriptionController,
                    leading: SvgPicture.asset(
                      "assets/svg/description_text.svg",
                    ),
                  ),
                ),

                SizedBox(height: context.mediaQueryHeight / 40),
                // submit button
                RoundButton(
                  loading: viewModel.loading,
                  title: "Submit & Continue",
                  onPress: () {
                    if (viewModel.validateSellTruckFields(context)) {
                      viewModel.submitData(context);
                    }
                  },
                ),

                SizedBox(height: context.mediaQueryHeight / 20),
              ],
            ),
          ),
        ),
        if (viewModel.loading) // Show loading animation when loading is true
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Lottie.asset(
                'assets/animations/loading.json',
                width: 150.w,
                height: 150.h,
              ),
            ),
          ),
      ],
    );
  }
}
