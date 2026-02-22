import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view_model/filter_view_model.dart';
import '../view_model/truck_view_model.dart';

class SelectTransmissionWidget extends StatelessWidget {
  const SelectTransmissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: context.mediaQueryHeight / 20, // Decreased height
                width: context.mediaQueryHeight / 20, // Decreased width
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/svg/assembly.svg"),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Assembly',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Consumer<TruckViewModel>(
                    builder: (context, provider, _) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                provider.selectTransmission('Imported');
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.9,
                                    child: SizedBox(
                                      height: 22.h,
                                      width: 22.w,
                                      child: Radio<String>(
                                        fillColor:
                                            MaterialStateProperty.resolveWith<
                                              Color
                                            >((states) {
                                              if (states.contains(
                                                MaterialState.selected,
                                              )) {
                                                return AppColors.primary;
                                              }
                                              return Colors.grey;
                                            }),
                                        value: 'Imported',
                                        groupValue:
                                            provider.selectedTransmission,
                                        onChanged: (value) {
                                          provider.selectTransmission(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Imported',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.selectTransmission('Local');
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.9,
                                    child: SizedBox(
                                      height: 22.h,
                                      width: 22.w,
                                      child: Radio<String>(
                                        fillColor:
                                            MaterialStateProperty.resolveWith<
                                              Color
                                            >((states) {
                                              if (states.contains(
                                                MaterialState.selected,
                                              )) {
                                                return AppColors.primary;
                                              }
                                              return Colors.grey;
                                            }),
                                        value: 'Local',
                                        groupValue:
                                            provider.selectedTransmission,
                                        onChanged: (value) {
                                          provider.selectTransmission(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Local',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectTransmissionWidgetForFilter extends StatelessWidget {
  const SelectTransmissionWidgetForFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4), // Add spacing below the title

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: context.mediaQueryHeight / 20, // Decreased height
                width: context.mediaQueryHeight / 20, // Decreased width
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/svg/assembly.svg"),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Assembly',
                    style: TextStyle(
                      color: Color(0xff026635),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 5), // Add spacing below the title

                Consumer<FilterVM>(
                  builder: (context, provider, _) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.toggleTransmission('Imported');
                            },
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Checkbox(
                                      value: provider.selectedTransmissions
                                          .contains('Imported'),
                                      onChanged: (value) {
                                        provider.toggleTransmission('Imported');
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  'Imported',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.toggleTransmission('Local');
                            },
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Checkbox(
                                      value: provider.selectedTransmissions
                                          .contains('Local'),
                                      onChanged: (value) {
                                        provider.toggleTransmission('Local');
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  'Local',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
