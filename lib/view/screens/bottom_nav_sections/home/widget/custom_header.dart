import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? actionPress;
  final bool isChangeActionColor;
  final bool isShowSeeMoreButton;

  const CustomHeader(
      {super.key,
      required this.title,
      this.actionText = MyStrings.viewAll,
      this.actionPress,
      this.isChangeActionColor = false,
      this.isShowSeeMoreButton = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(height: Dimensions.space20),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    title.tr,
                    style: tajawal20White700.copyWith(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  )),
              // const Spacer(),
              isShowSeeMoreButton
                  ? Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: actionPress,
                          child: Text(
                            actionText.tr,
                            style: tajawal15PrimaryColor500.copyWith(
                                color: isChangeActionColor &&
                                        Get.find<HomeController>()
                                                .roomList
                                                .length >
                                            1
                                    ? MyColor.primaryColor
                                    : MyColor.bodyTextColor),
                            textAlign: TextAlign.end,
                          )))
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: Dimensions.space16),
      ],
    );
  }
}
