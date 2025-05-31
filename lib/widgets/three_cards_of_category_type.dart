import 'package:flutter/cupertino.dart';

import '../constant_and_api/aaspas_constant.dart';

class ThreeCardsOfCategoryType extends StatelessWidget {
  ThreeCardsOfCategoryType({
    super.key,
    // required this.shops,
    // required this.serviceProvider,
    // required this.property,
  });
  // String shops;
  // String serviceProvider;
  // String property;

  List<String> threeCards = [
    AaspasImages.shops,
    AaspasImages.serviceProvider,
    AaspasImages.property,
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: Wrap(
          spacing: 10, // horizontal spacing
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 6, // vertical spacing
          children: List.generate(3, (index) {
            return Container(
              width: 120, // fixed or flexible width
              height: 120,
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              clipBehavior: Clip.hardEdge,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  fit: BoxFit.cover,
                  threeCards[index],
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      fit: BoxFit.cover,
                      AaspasImages.shopPlaceholder,
                    ); // fallback image
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
