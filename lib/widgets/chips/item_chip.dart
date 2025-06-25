import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant_and_api/aaspas_constant.dart';

class ItemChip extends StatefulWidget {
  const ItemChip({
    super.key,
    required this.itemName,
    this.width = 110,
    // required this.onTap,
  });

  final String? itemName;
  final double width;
  // final VoidCallback onTap;
  @override
  State<ItemChip> createState() => _ItemChipState();
}

class _ItemChipState extends State<ItemChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 55,
        maxHeight: 55,
        minWidth: widget.width,
        maxWidth: widget.width,
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFECECEC), width: 1),
        color: AaspasColors.itemChipBg,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              widget.itemName ?? 'Not Available',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,

              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  height: 1.25,
                  color: AaspasColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemChipClose extends StatefulWidget {
  const ItemChipClose({super.key, required this.itemName});

  final String? itemName;
  @override
  State<ItemChipClose> createState() => _ItemChipCloseState();
}

class _ItemChipCloseState extends State<ItemChipClose> {
  @override
  Widget build(BuildContext context) {
    print("///////////////////// in item chip close");
    print(widget.itemName);
    return Container(
      constraints: BoxConstraints(
        minHeight: 55,
        maxHeight: 55,
        minWidth: 148,
        maxWidth: 188,
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFECECEC), width: 1),
        color: AaspasColors.soft2,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            // fit: FlexFit.tight,
            child: Text(
              widget.itemName ?? 'Not Available',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,

              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  height: 1.25,
                  color: AaspasColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SvgPicture.asset(AaspasIcons.closeRelated),
        ],
      ),
    );
  }
}
