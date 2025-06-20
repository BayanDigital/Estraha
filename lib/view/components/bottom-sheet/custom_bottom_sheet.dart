import 'package:flutter/material.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';

class CustomBottomSheet {
  final Widget child;
  bool isNeedMargin;
  final VoidCallback? voidCallback;
  final Color bgColor;
  final double horizontalPadding;

  CustomBottomSheet(
      {required this.child,
      this.isNeedMargin = false,
      this.voidCallback,
      this.bgColor = MyColor.colorWhite,
      this.horizontalPadding = 15});

  void customBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 50),
                curve: Curves.decelerate,
                child: Container(
                  margin: isNeedMargin
                      ? const EdgeInsets.only(left: 15, right: 15, bottom: 15)
                      : EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: Dimensions.space12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: isNeedMargin
                          ? BorderRadius.circular(15)
                          : const BorderRadius.vertical(
                              top: Radius.circular(15))),
                  child: child,
                ),
              ),
            )).then((value) => voidCallback);
  }

  void filterBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 50),
                curve: Curves.decelerate,
                child: Container(
                  margin: isNeedMargin
                      ? const EdgeInsets.only(left: 15, right: 15, bottom: 15)
                      : EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: Dimensions.space12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: child,
                ),
              ),
            )).whenComplete(() => voidCallback);
  }
}
