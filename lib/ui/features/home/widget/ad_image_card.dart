import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/core/theme/theme_text.dart';
import 'package:truck_mandi/ui/features/home/view_model/ad_image_provider.dart';

class AdImageCard extends StatelessWidget {
  final List<String> images;

  const AdImageCard({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return images.length <= 1
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 12.0),
                child: Row(
                  children: [
                    Text('Manage this Ads', style: Themetext.headline),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.asset(
                  images.first,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ChangeNotifierProvider(
            create: (_) => AdImageProvider(images),
            child: Consumer<AdImageProvider>(
              builder: (context, provider, _) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Navigation Buttons
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Manage this Ads', style: Themetext.headline),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: provider.previousImage,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: SvgPicture.asset(
                                      'assets/svg/arrow_back.svg',
                                      color: provider.currentIndex > 0
                                          ? AppColors.primary
                                          : Colors.grey,
                                      width:
                                          MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: provider.nextImage,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: SvgPicture.asset(
                                      'assets/svg/arrow_right.svg',
                                      color:
                                          provider.currentIndex <
                                              provider.totalImages - 1
                                          ? AppColors.primary
                                          : Colors.grey,
                                      width:
                                          MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Image Display with Counter
                      Stack(
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image.asset(
                              provider.currentImage,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Image Counter
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 12,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    // "${provider.currentIndex + 1} /
                                    " ${provider.totalImages}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Image.asset(
                                    'assets/images/list_of_images.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
