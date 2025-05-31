import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final double spacing;
  final VoidCallback onPressed;
  // final Color color;
  final Color textColor;
  final SvgPicture? svgPicture;
  final BoxDecoration? decoration;
  final BoxConstraints? constraints;
  final EdgeInsets padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    // this.color = Colors.purple,
    this.textColor = Colors.white,
    this.svgPicture,
    this.decoration,
    this.constraints,
    this.fontSize = 16,
    this.spacing = 7.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        constraints: constraints,
        // color: Colors.brown,
        // width: 120,
        // height: 100,
        padding: padding,
        decoration: decoration,
        child: Row(
          spacing: spacing,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            svgPicture ?? SvgPicture.asset("assets/icons/whatsapp_white.svg"),
            SizedBox(width: 1),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
