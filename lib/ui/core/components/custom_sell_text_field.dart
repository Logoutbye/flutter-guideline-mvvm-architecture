import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/core/theme/theme_text.dart';

class CustomSellTextField extends StatefulWidget {
  final String titleText;
  final String hintText;
  final TextEditingController controller;

  // Styling
  final Color color;
  final Color borderColor;
  final double borderRadius;

  // Behavior
  final bool readOnly;
  final bool isPassword;
  final bool isNumberOnly;
  final bool formatAsPrice;
  final int? minLines;
  final int? maxLines;
  final bool hasDivider;

  // Widgets
  final Widget? leading;
  final Widget? trailing;
  final Widget? radioWidget;

  final VoidCallback? onTrailingTap;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool isRadio;

  const CustomSellTextField({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.controller,
    this.color = Colors.white,
    this.borderColor = Colors.black26,
    this.borderRadius = 12,
    this.readOnly = false,
    this.isPassword = false,
    this.isNumberOnly = false,
    this.formatAsPrice = false,
    this.minLines = 1,
    this.maxLines,
    this.leading,
    this.trailing,
    this.radioWidget,
    this.onTrailingTap,
    this.onChanged,
    this.errorText,
    this.isRadio = false,
    this.hasDivider = true,
  });

  @override
  State<CustomSellTextField> createState() => _CustomSellTextFieldState();
}

class _CustomSellTextFieldState extends State<CustomSellTextField> {
  late final NumberFormat _formatter;
  bool _updatingText = false;

  @override
  void initState() {
    super.initState();
    _formatter = NumberFormat('#,###');

    if (widget.formatAsPrice) {
      widget.controller.addListener(_formatPrice);
    }
  }

  void _formatPrice() {
    if (_updatingText) return;
    _updatingText = true;

    String oldText = widget.controller.text;
    String plainText = oldText.replaceAll(',', '');
    if (plainText.isEmpty) {
      _updatingText = false;
      return;
    }

    final number = int.tryParse(plainText);
    if (number != null) {
      final newText = _formatter.format(number);
      if (newText != oldText) {
        final cursorPos = newText.length;
        widget.controller
          ..text = newText
          ..selection = TextSelection.collapsed(offset: cursorPos);
      }
    }
    _updatingText = false;
  }

  @override
  void dispose() {
    if (widget.formatAsPrice) {
      widget.controller.removeListener(_formatPrice);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.color,
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          margin: EdgeInsets.only(top: 8.sp),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: widget.isRadio
                    ? widget.radioWidget ?? Container()
                    : TextFormField(
                        controller: widget.controller,
                        readOnly: widget.readOnly,
                        obscureText: widget.isPassword,
                        keyboardType: widget.isNumberOnly
                            ? TextInputType.number
                            : TextInputType.text,
                        minLines: widget.minLines,
                        maxLines: widget.maxLines ?? 1,
                        inputFormatters: widget.isNumberOnly
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : [],
                        style: Themetext.subheadline.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                        onTap: () {
                          if (widget.readOnly && widget.onTrailingTap != null) {
                            widget.onTrailingTap!();
                          }
                        },
                        onTapOutside: (event) => Utils.dismissKeyboard(context),
                        decoration: InputDecoration(
                          hintText: widget.errorText == null
                              ? widget.hintText
                              : null,
                          hintStyle: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          errorText: widget.errorText,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.sp,
                            horizontal: 8,
                          ),
                          suffixIcon: widget.trailing != null
                              ? InkWell(
                                  onTap: widget.onTrailingTap,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: widget.trailing,
                                  ),
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          if (widget.formatAsPrice) return;
                          widget.onChanged?.call(value);
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
