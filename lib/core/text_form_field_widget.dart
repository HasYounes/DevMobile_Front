import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/consts.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController myController;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final AutovalidateMode autoValidateMode;
  final bool obscureText;
  final Function(String)? onFieldSubmitted;
  final String? suffixWidget;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final int maxLines;
  final int? maxLength;
  final Function(String)? onChange;
  final String? iconImage;
  final List<TextInputFormatter>? inputFormatters;
  final bool isGiveBottomPadding;
  final bool isGiveTopPadding;
  final bool isSvg;
  final bool readOnly;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final double verticalPadding;
  final Color textColor;

  const TextFormFieldWidget({
    super.key,
    this.hintText = '',
    required this.myController,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.suffixWidget,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChange,
    this.maxLength,
    this.inputFormatters,
    this.isGiveBottomPadding = true,
    this.isGiveTopPadding = true,
    this.iconImage = '',
    this.isSvg = true,
    this.readOnly = false,
    this.prefixWidget,
    this.borderRadius = 10,
    this.verticalPadding = 0,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.textColor = mainAppColorTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isGiveBottomPadding ? 20 : 0),
      child: TextFormField(
        readOnly: readOnly,
        obscureText: obscureText,
        controller: myController,
        validator: validator,
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        onChanged: onChange,
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        textInputAction: textInputAction,
        keyboardType: textInputType,
        autovalidateMode: autoValidateMode,
        autofocus: false,
        decoration: InputDecoration(
          fillColor: const Color(0xFFCFD9E8),
          filled: true,
          suffixText: suffixWidget,
          suffixStyle: const TextStyle(
            color: blackColor,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixWidget,
          prefixIconConstraints: const BoxConstraints(
            minHeight: 10,
            minWidth: 55,
          ),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 10,
            minWidth: 55,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF5C79A4),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: whiteColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: whiteColor,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: whiteColor,
              width: 1,
            ),
          ),
          errorStyle: const TextStyle(
            color: alertColor,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: verticalPadding,
          ),
        ),
      ),
    );
  }
}
