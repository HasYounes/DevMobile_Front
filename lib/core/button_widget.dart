import 'package:flutter/material.dart';

import 'consts.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double width;
  final double height;
  final double elevation;
  final double fontSize;
  final Color btnColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final double padding;
  final FontWeight fontWeight;
  final double borderWidth;

  const ButtonWidget({
    super.key,
    required this.text,
    this.width = double.infinity,
    this.height = 52,
    this.elevation = 0,
    this.fontSize = 14,
    this.onPressed,
    this.btnColor = buttonColor,
    this.textColor = whiteColor,
    this.borderColor = buttonColor,
    this.borderRadius = 10,
    this.padding = 0,
    this.fontWeight = FontWeight.w800,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        width: width,
        height: height,
        child: MaterialButton(
          onPressed: onPressed,
          height: height,
          minWidth: width,
          elevation: elevation,
          color: btnColor,
          disabledColor: borderColor,
          focusElevation: 100,
          highlightElevation: 100,
          disabledElevation: 100,
          hoverElevation: 100,
          padding: EdgeInsets.all(padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          child: Center(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                overflow: TextOverflow.ellipsis,
                // letterSpacing: -0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
