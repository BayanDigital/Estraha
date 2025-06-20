// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class PreviewImage extends StatefulWidget {
  String url;
  PreviewImage({super.key, required this.url});

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  @override
  void initState() {
    widget.url = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            }),
      ),
      body: InteractiveViewer(
        child: CachedNetworkImage(
          imageUrl: widget.url.toString(),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              boxShadow: const [],
              // borderRadius:  BorderRadius.circular(radius),
              image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
            ),
          ),
          placeholder: (context, url) => SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
              child: Center(
                child: SpinKitFadingCube(
                  color: MyColor.getPrimaryColor().withOpacity(0.3),
                  size: Dimensions.space20,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
              child: Center(
                child: Icon(
                  Icons.image,
                  color: MyColor.getGreyColor().withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
