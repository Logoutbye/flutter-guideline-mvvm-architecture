import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/configs/app_constants.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view_model/truck_view_model.dart';
import 'package:truck_mandi/ui/features/sell_trucks/widget/show_selection_bottom_sheet.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view/select_transmission_widget.dart';
import 'package:truck_mandi/ui/core/components/custom_sell_text_field.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view/truck_media_picker.dart';
import 'package:truck_mandi/ui/core/components/text_filed_for_description.dart';
import 'package:truck_mandi/ui/features/sell_trucks/widget/choose_category_botttom_sheet.dart';
import 'select_engine_type_widget.dart';

class SellTruckView extends StatefulWidget {
  const SellTruckView({super.key});

  @override
  State<SellTruckView> createState() => _SellTruckViewState();
}

class _SellTruckViewState extends State<SellTruckView> {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<TruckViewModel>(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.whiteSccafold,

          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.h),
            child: AppBar(
              centerTitle: true,
              surfaceTintColor: AppColors.whiteSccafold,
              leading: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 20),
                  ),
                ),
              ),
              title: Text(
                "Sell your Truck",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 5.0, top: 13, right: 5),
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                truckMediaPicker(
                  context,
                  "Upload Media",
                  Provider.of<TruckViewModel>(context),
                ),

                SizedBox(height: context.mediaQueryHeight / 70),
                SizedBox(
                  height: 20.h,
                  child: Text(
                    '${viewModel.cateogryController.text.split(' - ').first} ${"Information"}',
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
                  leading: SvgPicture.asset(
                    'assets/svg/sort copy.svg',
                    height: 18.h,
                  ),
                ),

                CustomSellTextField(
                  readOnly: true,
                  errorText: viewModel.fieldErrors['Category'],
                  titleText: "Category",
                  hintText: "Select Category",
                  controller: viewModel.cateogryController,
                  leading: SvgPicture.asset(
                    'assets/svg/truck_im.svg',
                    height: 18.h,
                  ),
                  onTrailingTap: () {
                    String categoryTitle =
                        viewModel.cateogryController.text.isNotEmpty
                        ? viewModel.cateogryController.text.split(' - ').first
                        : '';
                    Map<String, List<String>> result = getCategoryWithValues(
                      categoryTitle,
                    );
                    chooseCategoryBottomSheet(
                      context: context,
                      title: "Select Category",
                      data: result.isNotEmpty ? result : categoriesList,
                      onItemSelected: (selectedItem) {
                        viewModel.cateogryController.text = selectedItem;
                      },
                      selectedParent: categoryTitle,
                      initialSelectedValue: viewModel.cateogryController.text,
                    );
                  },
                  trailing: SvgPicture.asset(
                    height: 10.h,
                    width: 10.w,
                    "assets/svg/arrow-down.svg",
                  ),
                ),

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
                    width: 10.w,
                    "assets/svg/arrow-down.svg",
                  ),
                ),

                //price
                CustomSellTextField(
                  errorText: viewModel.fieldErrors['Price'],
                  titleText: "Price (PKR)",
                  hintText: "Enter Price",
                  isNumberOnly: true,
                  controller: viewModel.priceController,
                  leading: SvgPicture.asset('assets/svg/price.svg'),
                  onChanged: (value) {
                    String sanitizedValue = value.replaceAll(
                      RegExp(r'[.,]'),
                      '',
                    );
                    if (sanitizedValue.length > 12) {
                      sanitizedValue = sanitizedValue.substring(0, 12);
                    }
                    viewModel.priceController.text = sanitizedValue;
                  },
                ),

                CustomSellTextField(
                  errorText: viewModel.fieldErrors['Truck Year'],
                  titleText: "Truck Year",
                  hintText: "Enter Model Year",
                  controller: viewModel.modelYearController,
                  leading: SvgPicture.asset('assets/svg/calender.svg'),
                  readOnly: true,
                  trailing: SvgPicture.asset("assets/svg/arrow-down.svg"),
                  onTrailingTap: () {
                    showSelectionBottomSheet(
                      context: context,
                      title: "Truck Year",
                      hintText: "Select By Year",
                      items: vehicleRegistrationYears,
                      onItemSelected: (selectedItem) {
                        viewModel.modelYearController.text = selectedItem;
                      },
                      selectedItem: viewModel
                          .modelYearController
                          .text, // Pre-select current year
                    );
                  },
                ),
                //Registered in
                // Registered In
                CustomSellTextField(
                  errorText: viewModel.fieldErrors['Registered In'],
                  titleText: "Registered In",
                  hintText: "Enter Registered In",
                  controller: viewModel.registeredInController,
                  leading: SvgPicture.asset('assets/svg/registered_in.svg'),
                  readOnly: true, // Added to match other fields
                  trailing: SvgPicture.asset("assets/svg/arrow-down.svg"),
                  onTrailingTap: () {
                    showSelectionBottomSheet(
                      context: context,
                      title: "Registered In",
                      hintText: "Search by Registration Area",
                      items: pakistanProvinces,
                      isSearchEnabled: true,
                      onItemSelected: (selectedItem) {
                        viewModel.registeredInController.text = selectedItem;
                      },
                      selectedItem: viewModel
                          .registeredInController
                          .text, // Pre-select current province
                    );
                  },
                ),
                //Truck make
                // Truck Make
                CustomSellTextField(
                  errorText: viewModel.fieldErrors['Truck Make'],
                  titleText: "Truck Make",
                  hintText: "Enter Make",
                  controller: viewModel.truckMakeController,
                  leading: SvgPicture.asset('assets/svg/cpu.svg', height: 19.h),
                  readOnly: true, // Added to match other fields
                  trailing: SvgPicture.asset("assets/svg/arrow-down.svg"),
                  onTrailingTap: () {
                    showSelectionBottomSheet(
                      context: context,
                      title: "Truck Make",
                      hintText: "Select By Make",
                      items: carMakes,
                      onItemSelected: (selectedItem) {
                        viewModel.truckMakeController.text = selectedItem;
                      },
                      selectedItem: viewModel
                          .truckMakeController
                          .text, // Pre-select current make
                    );
                  },
                ),
                // enigne type
                SelectEngineTypeWidget(),

                SelectTransmissionWidget(),
                SizedBox(height: context.mediaQueryHeight / 50),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 145.h,

                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(color: Colors.black26, width: 1.0),
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

                SizedBox(height: context.mediaQueryHeight / 50),

                // submit button
                Consumer<TruckViewModel>(
                  builder:
                      (
                        BuildContext context,
                        TruckViewModel value,
                        Widget? child,
                      ) {
                        return RoundButton(
                          loading: value.loading,
                          title: "Submit & Continue",
                          onPress: () {
                            if (viewModel.validateSellTruckFields(context)) {
                              viewModel.submitData(context);
                            } else {
                              print(':::');
                            }
                          },
                        );
                      },
                ),

                SizedBox(height: context.mediaQueryHeight / 20),
              ],
            ),
          ),
        ),
        if (viewModel.loading)
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

Map<String, List<String>> getCategoryWithValues(String categoryTitle) {
  if (categoriesList.containsKey(categoryTitle)) {
    return {categoryTitle: categoriesList[categoryTitle]!};
  } else {
    return {};
  }
}
