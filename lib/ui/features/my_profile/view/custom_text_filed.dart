import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Color color;
  final Color borderColor;
  final ValueChanged<String>? onPhoneNumberChanged;
  final bool isPassword;
  final bool autoDismissKeyboard;
  final int? minLines;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,

    this.color = Colors.transparent,
    this.borderColor = Colors.black38,
    this.onPhoneNumberChanged,
    this.isPassword = false,
    this.autoDismissKeyboard = true,
    this.minLines = 1,
    this.maxLines,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              cursorColor: AppColors.primary,
              cursorHeight: 18,
              obscureText: widget.isPassword ? _isObscure : false,
              style: TextStyle(color: Colors.black, fontSize: 15.sp),
              minLines: widget.minLines,
              maxLines: widget.isPassword ? 1 : widget.maxLines,
              onTapOutside: (event) {
                if (widget.autoDismissKeyboard) {
                  Utils.dismissKeyboard(context);
                }
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(left: 10.w),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 15,
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
              onChanged: (value) {
                if (widget.onPhoneNumberChanged != null) {
                  widget.onPhoneNumberChanged!(value);
                }
              },
            ),
          ),
          if (widget.isPassword)
            IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.black38,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
        ],
      ),
    );
  }
}
