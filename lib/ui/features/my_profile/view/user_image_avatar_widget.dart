import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/ui/core/components/loading_widget.dart';
import 'package:truck_mandi/ui/features/my_profile/view/profile_view.dart';

//custom network image widget, we will used this widget show images, also handled exceptions
// this widget is generic, we can change it and this change will appear across the app

class UserImageAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height, borderRadius, iconSize;
  final BoxFit boxFit;
  final bool isForVerify;
  const UserImageAvatarWidget({
    Key? key,
    required this.imageUrl,
    this.width = 50,
    this.isForVerify = false,
    this.height = 50,
    this.borderRadius = 50,
    this.iconSize = 20,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isForVerify == false
          ? () {
              MyNavigationService.push(ProfileViewRedesigned());
            }
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageUrl == ''
            ? Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.black,
                  // size: iconSize,
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                width: width,
                height: height,
                imageBuilder: (context, imageProvider) => Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    image: DecorationImage(image: imageProvider, fit: boxFit),
                  ),
                ),
                placeholder: (context, url) => Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: LoadingWidget(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(Icons.error_outline, size: iconSize),
                ),
              ),
      ),
    );
  }
}
