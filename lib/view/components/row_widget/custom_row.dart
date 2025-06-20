import 'package:flutter/material.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:get/get.dart';

import '../../../core/utils/my_color.dart';
import '../status_widget.dart';
import '../divider/custom_divider.dart';

class CustomRow extends StatelessWidget {
  final String firstText, lastText;
  final bool isStatus, isAbout, showDivider;
  final Color? statusTextColor;
  final bool hasChild;
  final Widget? child;

  const CustomRow(
      {Key? key,
      this.child,
      this.hasChild = false,
      this.statusTextColor,
      required this.firstText,
      required this.lastText,
      this.isStatus = false,
      this.isAbout = false,
      this.showDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasChild
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    firstText.tr,
                    style:
                        regularDefault.copyWith(color: MyColor.getTextColor()),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )),
                  child ?? const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              showDivider
                  ? const Divider(
                      color: MyColor.borderColor,
                    )
                  : const SizedBox(),
              showDivider
                  ? const SizedBox(
                      height: 5,
                    )
                  : const SizedBox(),
            ],
          )
        : isAbout
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(firstText.tr,
                      style:
                          regularDefault.copyWith(color: MyColor.primaryColor)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    lastText.tr,
                    style: regularDefault.copyWith(
                        color:
                            isStatus ? statusTextColor : MyColor.primaryColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        firstText.tr,
                        style: regularDefault.copyWith(
                            color: MyColor.primaryTextColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                      isStatus
                          ? StatusWidget(
                              status: lastText,
                              color: MyColor.greenP,
                            )
                          : Flexible(
                              child: Text(
                              lastText.tr,
                              maxLines: 2,
                              style: regularDefault.copyWith(
                                  color: isStatus
                                      ? MyColor.greenSuccessColor
                                      : MyColor.primaryTextColor),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ))
                    ],
                  ),
                  const SizedBox(height: 5),
                  showDivider
                      ? CustomDivider(
                          color: MyColor.transparentColor.withOpacity(.2),
                        )
                      : const SizedBox(),
                  showDivider
                      ? const SizedBox(
                          height: 5,
                        )
                      : const SizedBox(),
                ],
              );
  }
}
