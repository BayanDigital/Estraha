import 'package:booking_box/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';

class CustomLoader extends StatelessWidget {
  final bool isFullScreen;
  final bool isPagination;
  final double strokeWidth;
  final Color loaderColor;

  const CustomLoader({
    Key? key,
    this.isFullScreen = false,
    this.isPagination = false,
    this.strokeWidth = 1,
    this.loaderColor = MyColor.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: SpinKitThreeBounce(
              color: loaderColor,
              size: 20.0,
            )),
          )
        : isPagination
            ? Center(
                child: SpinKitThreeBounce(
                color: loaderColor,
                size: 20.0,
              ))
            : Center(
                child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: MyColor.primaryColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 1.8,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      MyStrings.loading.tr,
                      style: tajawal14White400.copyWith(
                          color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ));
  }
}
