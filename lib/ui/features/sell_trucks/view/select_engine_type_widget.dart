import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view_model/filter_view_model.dart';
import '../view_model/truck_view_model.dart';

class SelectEngineTypeWidget extends StatelessWidget {
  const SelectEngineTypeWidget({super.key});

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
                height: context.mediaQueryHeight / 20,

                width: context.mediaQueryHeight / 20,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/svg/condition.svg"),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Engine Type',
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
                                provider.selectEngineType('4c');
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale:
                                        0.9, // Decreased scale for smaller size
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
                                        value: '4c',
                                        groupValue: provider.selectedEngineType,
                                        onChanged: (value) {
                                          provider.selectEngineType(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),

                                  Text(
                                    '4c',
                                    style: TextStyle(
                                      fontSize: 14, // Adjusted font size
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 10.w), // Adjusted spacing
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.selectEngineType('6c');
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale:
                                        0.9, // Decreased scale for smaller size
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
                                        value: '6c',
                                        groupValue: provider.selectedEngineType,
                                        onChanged: (value) {
                                          provider.selectEngineType(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),

                                  Text(
                                    '6c',
                                    style: TextStyle(
                                      fontSize: 14, // Adjusted font size
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 10.w), // Adjusted spacing
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.selectEngineType('8c');
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale:
                                        0.9, // Decreased scale for smaller size
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
                                        value: '8c',
                                        groupValue: provider.selectedEngineType,
                                        onChanged: (value) {
                                          provider.selectEngineType(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),

                                  Text(
                                    '8c',
                                    style: TextStyle(
                                      fontSize: 14, // Adjusted font size
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 10.w), // Adjusted spacing
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

class SelectEngineTypeWidgetForFilter extends StatelessWidget {
  const SelectEngineTypeWidgetForFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: context.mediaQueryHeight / 20, // Decreased height
                width: context.mediaQueryHeight / 20, // Decreased width
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLight,
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/svg/condition.svg"),
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
                    'Engine Type',
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
                              provider.selectEngineType('4c');
                            },
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Checkbox(
                                      // visualDensity: VisualDensity.compact,
                                      value: provider.selectedEngineTypes
                                          .contains('4c'),
                                      onChanged: (value) {
                                        provider.selectEngineType('4c');
                                      },
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 3.w),
                                Text(
                                  '4c',
                                  style: TextStyle(
                                    // fontSize: 16,
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
                              provider.selectEngineType('6c');
                            },
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Checkbox(
                                      value: provider.selectedEngineTypes
                                          .contains('6c'),
                                      onChanged: (value) {
                                        provider.selectEngineType('6c');
                                      },
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 3.w),
                                Text(
                                  '6c',
                                  style: TextStyle(
                                    // fontSize: 16,
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
                              provider.selectEngineType('8c');
                            },
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Checkbox(
                                      value: provider.selectedEngineTypes
                                          .contains('8c'),
                                      onChanged: (value) {
                                        provider.selectEngineType('8c');
                                      },
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 1.w),
                                Text(
                                  '8c',
                                  style: TextStyle(
                                    // fontSize: 16,
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
        // SizedBox(
        //   height: 5,
        // ),
        // SizedBox(
        //   height: 0.5,
        //   child: Divider(
        //     endIndent: 10,
        //     indent: 50,
        //     color: Colors.grey[350],
        //   ),
        // ),
      ],
    );
  }
}
