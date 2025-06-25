import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant_and_api/aaspas_constant.dart';

class LabelCard extends StatelessWidget {
  const LabelCard({
    super.key,
    required this.title,
    // this.bgColor = Colors.white,
    this.color = Colors.black,
    this.spacing = 6,
    this.iconSize = 24,
    this.fontSize = 6,
    this.verticalPadding = 6,
    this.horizontalPadding = 6,
    this.iconPath = "assets/icons/verified.svg",
    this.showIcon = false,
    this.fontWeight,
    this.widthLabel = double.infinity,
    this.constraints,
    this.decoration = const BoxDecoration(
      color: AaspasColors.textHalfBlack,
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    this.onTap,
  });

  // Text
  final String title;
  final Color color;
  final double fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  // Icon
  final bool showIcon;
  final String iconPath;
  final double iconSize;

  // Background
  // final Color bgColor;
  final BoxDecoration? decoration;
  final BoxConstraints? constraints;

  // Border

  // Spacing
  final double spacing;
  final double verticalPadding;
  final double horizontalPadding;
  final double widthLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        constraints: constraints,
        decoration: decoration,
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) ...[
              SvgPicture.asset(iconPath, height: iconSize, width: iconSize),
              SizedBox(width: spacing),
              // 👈 this adds space between icon and text
            ],
            if (showIcon)
              Flexible(
                child: Text(
                  title,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(color: color),
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
            if (!showIcon)
              Text(
                title,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: color),
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
