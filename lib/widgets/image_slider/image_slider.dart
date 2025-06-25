import 'package:aaspas/constant_and_api/aaspas_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, this.imageLinks = const []});
  final List<dynamic?> imageLinks;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List imageList = [];
  bool networkImage = false;
  List dummyList = [
    // {'id': 1, 'image_path': 'assets/slider/1.png'},
    // {'id': 2, 'image_path': 'assets/slider/2.png'},
    // {'id': 3, 'image_path': 'assets/slider/3.png'},
    {
      'id': 1,
      'image_path':
          'https://raw.githubusercontent.com/aarifhusainwork/aaspas-storage-assets/refs/heads/main/AppWizard/AltImages/propertyDummyImages/1.png',
    },
    {
      'id': 2,
      'image_path':
          'https://raw.githubusercontent.com/aarifhusainwork/aaspas-storage-assets/refs/heads/main/AppWizard/AltImages/propertyDummyImages/2.png',
    },
    {
      'id': 3,
      'image_path':
          'https://raw.githubusercontent.com/aarifhusainwork/aaspas-storage-assets/refs/heads/main/AppWizard/AltImages/propertyDummyImages/3.png',
    },
  ];

  bool containsMap(List list) {
    return list.any((element) => element is Map);
  }

  @override
  initState() {
    print("/////////////////widget.imageLinks");
    print(widget.imageLinks);
    print(containsMap(widget.imageLinks));
    if (widget.imageLinks.isEmpty) {
      imageList = [...dummyList];

      print("/////////////////////////////////// First is running");
      // print(imageList);
    } else if (containsMap(widget.imageLinks)) {
      imageList = [...dummyList];
      print("/////////////////////////////////// 2 is running");
    } else {
      print("/////////////////////////////////// 3 is running");
      networkImage = true;
      imageList = List.generate(
        widget.imageLinks.length,
        (index) => {'id': index + 1, 'image_path': widget.imageLinks[index]},
      );
    }

    super.initState();
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("/////// Image Slider Build");
    print(imageList);
    return SizedBox(
      child: Stack(
        children: [
          InkWell(
            onTap: () {},
            child: CarouselSlider(
              items:
                  imageList
                      .map(
                        (item) => Container(
                          clipBehavior: Clip.hardEdge,
                          width: double.infinity,
                          // height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AaspasImages.shopPlaceholder),
                              fit: BoxFit.cover, // covers entire container
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey,
                          ),
                          child:
                              networkImage
                                  ? CachedNetworkImage(
                                    imageUrl: item['image_path'],
                                    fit: BoxFit.cover,
                                    errorWidget:
                                        (context, url, error) => Image.asset(
                                          fit: BoxFit.cover,
                                          AaspasImages.shopPlaceholder,
                                        ),
                                  )
                                  : CachedNetworkImage(
                                    imageUrl: item['image_path'],
                                    fit: BoxFit.cover,
                                    errorWidget:
                                        (context, url, error) => Image.asset(
                                          fit: BoxFit.cover,
                                          AaspasImages.shopPlaceholder,
                                        ),
                                  ),
                          // : Image.asset(
                          //   item['image_path'],
                          //   fit: BoxFit.cover,
                          //   errorBuilder:
                          //       (context, url, error) => Image.asset(
                          //         fit: BoxFit.cover,
                          //         AaspasImages.shopPlaceholder,
                          //       ),
                          // ),
                        ),
                      )
                      .toList(),
              options: CarouselOptions(
                scrollPhysics: BouncingScrollPhysics(),
                autoPlay: (widget.imageLinks.length == 1) ? false : true,
                aspectRatio: 1,

                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  imageList.asMap().entries.map((entry) {
                    // print(entry);
                    // print(entry.key);
                    return GestureDetector(
                      onTap:
                          () => carouselController.jumpTo(
                            entry.key.toDouble(),
                            // duration: Duration(milliseconds: 800),
                            // curve: Curves.easeInOut,
                          ),
                      child: Container(
                        width: currentIndex == entry.key ? 17 : 7,
                        height: 7,
                        margin: EdgeInsets.symmetric(horizontal: 3.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AaspasColors.white,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color:
                              currentIndex == entry.key
                                  ? AaspasColors.primary
                                  : AaspasColors.white,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
