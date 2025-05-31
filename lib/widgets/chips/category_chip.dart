import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant_and_api/aaspas_constant.dart';

class CategoryChip extends StatefulWidget {
  const CategoryChip({
    super.key,
    required this.imageUrl,
    required this.catName,
  });
  final String imageUrl;
  final String catName;
  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 174,
        minWidth: 174,
        minHeight: 53,
        maxHeight: 53,
      ),
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFECECEC), width: 1),
        color: AaspasColors.categoryChipBg,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 53,
            height: 53,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
              image: DecorationImage(
                image: AssetImage(AaspasImages.shopPlaceholder),
                fit: BoxFit.cover, // covers entire container
              ),
            ),
            clipBehavior: Clip.hardEdge,

            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
              errorWidget:
                  (context, url, error) => Image.asset(
                    fit: BoxFit.cover,
                    AaspasImages.shopPlaceholder,
                  ),
            ),
          ),
          Flexible(
            child: Center(
              child: Text(
                widget.catName,
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
          ),
        ],
      ),
    );
  }
}

class CategoryChipClose extends StatefulWidget {
  const CategoryChipClose({
    super.key,
    required this.imageUrl,
    required this.catName,
  });
  final String imageUrl;
  final String catName;
  @override
  State<CategoryChipClose> createState() => _CategoryChipCloseState();
}

class _CategoryChipCloseState extends State<CategoryChipClose> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFECECEC), width: 1),
        color: AaspasColors.soft2,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 53,
            height: 53,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
              image: DecorationImage(
                image: AssetImage(AaspasImages.shopPlaceholder),
                fit: BoxFit.cover, // covers entire container
              ),
            ),
            clipBehavior: Clip.hardEdge,

            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
              errorWidget:
                  (context, url, error) => Image.asset(
                    fit: BoxFit.cover,
                    AaspasImages.shopPlaceholder,
                  ),
            ),
          ),
          Text(
            widget.catName,
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
          SvgPicture.asset(AaspasIcons.closeRelated),
        ],
      ),
    );
  }
}
