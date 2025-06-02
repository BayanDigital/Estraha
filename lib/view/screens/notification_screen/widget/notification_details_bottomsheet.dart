import 'package:booking_box/data/controller/notification/notification_controller.dart';
import 'package:booking_box/data/model/notification/notification_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/my_strings.dart';
import '../../../../../../core/utils/style.dart';
import '../../../components/divider/custom_divider.dart';

class NotificationDetailsBottomSheet extends StatelessWidget {
  final Datum notification;
  const NotificationDetailsBottomSheet({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      builder: (controller) => Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  MyStrings.message.tr,
                  style: boldLarge.copyWith(
                      color: MyColor.titleTextColor, fontSize: 16),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    color: MyColor.colorWhite,
                    padding: const EdgeInsets.only(
                        left: 15, right: 6, top: 0, bottom: 8),
                    child: const Icon(
                      Icons.close,
                      size: 17,
                      weight: 17,
                      color: MyColor.titleTextColor,
                    ),
                  ),
                ),
              )
            ],
          ),
          const CustomDivider(space: 10),
          Text(
            notification.message?.tr ?? "",
            style: mediumLarge,
          ),
          SizedBox(
            height: context.height * .02,
          )
        ],
      ),
    );
  }
}
