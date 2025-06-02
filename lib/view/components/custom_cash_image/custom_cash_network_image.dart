import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../custom_loader/image_loader.dart';

class CustomCashNetworkImage extends StatelessWidget {
  final double? imageHeight;
  final double? imageWidth;
  final String imageUrl;
  final Widget? imageBuilder;
  final double borderRadius;
  final String? loaderImage;

  const CustomCashNetworkImage(
      {super.key,
      this.imageHeight,
      this.imageWidth,
      required this.imageUrl,
      this.borderRadius = 0,
      this.imageBuilder,
      this.loaderImage,
      BoxFit fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          height: 139,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) {
            if (loaderImage != null) {
              return Image.asset(loaderImage!);
            } else {
              return const CustomImageLoader();
            }
          },
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
