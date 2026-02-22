import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/core/theme/theme_text.dart';

class TextFieldForDescription extends StatelessWidget {
  final String titleText;
  final String hintText;
  final TextEditingController controller;
  final Color color;
  final Color borderColor;

  final ValueChanged<String>? onPhoneNumberChanged;
  final bool isPassword;
  final bool readOnly;
  final int? minLines;
  final double? borderRadius;
  final int? maxLines;
  final Widget? leading;
  final Widget? trailing;
  final Widget? radioWidget;
  final VoidCallback? onTrailingTap;
  final String? errorText;
  final bool isNumberOnly;

  const TextFieldForDescription({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.controller,
    this.color = Colors.white,
    this.borderColor = Colors.black38,
    this.onPhoneNumberChanged,
    this.isPassword = false,
    this.readOnly = false,
    this.minLines = 1,
    this.borderRadius = 12,
    this.maxLines,
    this.leading,
    this.trailing,
    this.radioWidget,
    this.onTrailingTap,
    this.errorText,
    this.isNumberOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20.h,
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  titleText,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            TextFormField(
              cursorHeight: 18.sp,
              readOnly: readOnly,
              controller: controller,
              obscureText: isPassword,
              style: Themetext.subheadline.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
              minLines: minLines,
              maxLines: maxLines ?? minLines,
              keyboardType: isNumberOnly
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: isNumberOnly
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
              onTapOutside: (event) => Utils.dismissKeyboard(context),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: 0.h,
                  bottom: 30.h,
                  right: 12.w,
                  left: 7.w,
                ),
                filled: true, // Makes entire area clickable
                fillColor: Colors.transparent, // Transparent background
                hintText: errorText ?? hintText,

                hintStyle: TextStyle(
                  color: errorText == null ? Colors.black45 : Colors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                // errorText: errorText,
                errorMaxLines: 2, // Prevent overflow
                errorStyle: TextStyle(fontSize: 12.sp),
                border: InputBorder.none, // Original no border
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                suffixIcon: trailing != null
                    ? InkWell(
                        onTap: onTrailingTap,
                        child: Container(
                          height: 40.h, // Matches leading
                          padding: EdgeInsets.all(8.r), // Scaled, original 8.0
                          child: trailing,
                        ),
                      )
                    : null,
              ),
              onChanged: onPhoneNumberChanged,
            ),
          ],
        ),
      ),
    );
  }
}
