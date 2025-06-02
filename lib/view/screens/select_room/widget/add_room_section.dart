import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';
import 'package:booking_box/data/services/api_service.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';

class AddRoomSectionSelectScreen extends StatelessWidget {
  final int index;

  const AddRoomSectionSelectScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomSelectController>(
      builder: (controller) {
        var roomList = controller.roomList[index];

        var currency = Get.find<ApiClient>();

        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyStrings.option.tr,
                        style: boldLarge.copyWith(
                            fontFamily: "Tajawal",
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        height: Dimensions.space11,
                      ),
                      Row(
                        children: [
                          Icon(Icons.fiber_manual_record,
                              size: 8, color: Theme.of(context).primaryColor),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                            '${MyStrings.availableRoom.tr} ${roomList.availableRooms}',
                            style: regularDefault.copyWith(
                                fontFamily: "Tajawal",
                                color: Theme.of(context).primaryColor),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.space11,
                      ),
                      Row(
                        children: [
                          Icon(Icons.fiber_manual_record,
                              size: 8, color: Theme.of(context).primaryColor),
                          const SizedBox(width: Dimensions.space5),
                          Text("${MyStrings.roomPerNight.tr} ",
                              style: regularDefault.copyWith(
                                  fontFamily: "Tajawal",
                                  color: Theme.of(context).primaryColor)),
                          Expanded(
                              child: Text(
                                  "${currency.getCurrencyOrUsername(isSymbol: true).tr}${Converter.formatNumber(roomList.fare!, precision: 2)}",
                                  style: mediumDefault.copyWith(
                                      fontFamily: "Tajawal",
                                      color: Theme.of(context).primaryColor)))
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.space10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.fiber_manual_record,
                              size: 8, color: Theme.of(context).primaryColor),
                          const SizedBox(width: Dimensions.space5),
                          Expanded(
                              child: Text(
                                  '${Converter.formatNumber(roomList.discountPercentage!, precision: 0)}% ${MyStrings.discount.tr}',
                                  style: regularDefault.copyWith(
                                      fontFamily: "Tajawal",
                                      color: Theme.of(context).primaryColor))),
                        ],
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: Dimensions.space8),
                      Text(
                          '${currency.getCurrencyOrUsername(isSymbol: true).tr}${controller.getActualRoomFare(index)}',
                          style: regularSmall.copyWith(
                              color: MyColor.colorRed,
                              decoration: TextDecoration.lineThrough)),
                      const SizedBox(height: Dimensions.space8),
                      Text(
                          '${currency.getCurrencyOrUsername(isSymbol: true).tr}${controller.getDiscountedRoomFare(roomList.discountedFare!)}',
                          style: boldDefault.copyWith(
                              fontFamily: "Tajawal",
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(height: Dimensions.space8),
                      Text(
                          '+${Converter.formatNumber(controller.hotelDetailsScreenController.hotelSetting?.taxPercentage ?? '0', precision: 0)}% ${MyStrings.taxes.tr}',
                          style: regularSmall.copyWith(
                              fontFamily: "Tajawal",
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(height: Dimensions.space8),
                      Text(
                          "${MyStrings.forText.tr} ${controller.homeController.numberOfNights()} ${MyStrings.nightPerRoom.tr}",
                          style: regularSmall.copyWith(
                              fontFamily: "Tajawal",
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(height: Dimensions.space20),
                      GestureDetector(
                        onTap: () {
                          if (roomList.totalRoomCount <
                              int.parse(roomList.availableRooms ?? '0')) {
                            controller.addSelectedRoomList(roomList);
                            controller.assignGuestOnRoom(roomList);
                            controller.setTotalPayableAmount(double.parse(
                                roomList.discountedFare.toString()));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                              color: roomList.totalRoomCount <
                                      int.parse(roomList.availableRooms ?? '0')
                                  ? MyColor.primaryColor
                                  : MyColor.primaryColor.withOpacity(.6),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(MyStrings.select.tr,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: regularMediumLarge.copyWith(
                                  color: roomList.totalRoomCount <
                                          int.parse(
                                              roomList.availableRooms ?? '0')
                                      ? MyColor.colorWhite
                                      : MyColor.bodyTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Tajawal")),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
