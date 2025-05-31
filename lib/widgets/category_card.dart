import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constant_and_api/aaspas_constant.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryImage,
    required this.categoryName,
  });
  final String categoryName;
  final String categoryImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85, // fixed or flexible width
      height: 137,
      decoration: BoxDecoration(
        // color: Colors.lightGreen,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage(AaspasImages.shopPlaceholder),
                fit: BoxFit.cover, // covers entire container
              ),
            ),
            clipBehavior: Clip.hardEdge,

            // Image.network(
            //   fit: BoxFit.cover,
            //   "${allCategoriesList[index]["category_image"]}",
            //   errorBuilder: (context, error, stackTrace) {
            //     return Image.asset(
            //       fit: BoxFit.cover,
            //       'assets/images/shopPlaceholder.png',
            //     ); // fallback image
            //   },
            // ),
            //
            child: CachedNetworkImage(
              imageUrl: categoryImage,
              fit: BoxFit.cover,
              errorWidget:
                  (context, url, error) => Image.asset(
                    fit: BoxFit.cover,
                    AaspasImages.shopPlaceholder,
                  ),
            ),
          ),
          Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            textAlign: TextAlign.center,

            categoryName,

            style: TextStyle(
              height: 1.25,
              color: Colors.black,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
