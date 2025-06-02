// ignore_for_file: deprecated_member_use

import 'package:booking_box/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_images.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/controller/filter/filter_controller.dart';

class RatingAndClassSection extends StatelessWidget {
  final FilterController controller;

  const RatingAndClassSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: Dimensions.space15,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(color: MyColor.colorBlack.withOpacity(.3)),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      MyStrings.hotelClass.tr,
                      style: tajawal20White700.copyWith(
                          color: Theme.of(context).primaryColor),
                    ),
                    GestureDetector(
                        onTap: () {
                          controller.selectedHotelClass = -1;
                          controller.update();
                        },
                        child: Text(
                          MyStrings.reset.tr,
                          style: tajawal15PrimaryColor500.copyWith(
                              color: Theme.of(context).primaryColor),
                        )),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.space8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      controller.maxStarRating,
                      (index) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.setSelectedHotelClass(index);
                              },
                              child: Stack(
                                children: [
                                  Center(
                                    child: controller.selectedHotelClass ==
                                            index
                                        ? SvgPicture.asset(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 28,
                                            MyImages.selectedRatingStat)
                                        : SvgPicture.asset(
                                            MyImages.ratingStar,
                                            width: 28,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                  ),
                                  Positioned(
                                    top: 9,
                                    left: MyUtils.isRtl(context) ? null : 17.5,
                                    right: MyUtils.isRtl(context) ? 18 : null,
                                    child: Text(
                                      '${index + 1}',
                                      style: tajawal14White400.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                ),
                const SizedBox(
                  height: Dimensions.space15,
                ),
                Text(
                  "Select the number of stars to rate".tr,
                  style: tajawal14White400.copyWith(
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                    color: MyColor.colorBlack.withOpacity(.5), width: .5)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.facilities.tr,
                          style: tajawal20White700.copyWith(
                              color: Theme.of(context).primaryColor)),
                      GestureDetector(
                          onTap: () {
                            controller.toggleFacilities();
                          },
                          child: Text(
                            controller.facilities
                                ? MyStrings.viewLess.tr
                                : MyStrings.viewMore.tr,
                            style: tajawal14White400.copyWith(
                                color: Theme.of(context).primaryColor),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: List.generate(
                        controller.facilities
                            ? controller.facilitiesList.length
                            : controller.facilitiesList.length < 8
                                ? controller.facilitiesList.length
                                : 8,
                        (index) => GestureDetector(
                              onTap: () {
                                controller.setSelectedFacilities(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: .5,
                                        color:
                                            MyColor.colorBlack.withOpacity(.5)),
                                    color: controller
                                            .facilitiesList[index].isSelect
                                        ? MyColor.primaryColor.withOpacity(.5)
                                        : null),
                                child: Text(controller
                                    .facilitiesList[index].name
                                    .toString()
                                    .tr),
                              ),
                            )),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                    color: MyColor.colorBlack.withOpacity(.5), width: .5)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.amenities.tr,
                          style: tajawal20White700.copyWith(
                            color: Theme.of(context).primaryColor,
                          )),
                      GestureDetector(
                          onTap: () {
                            controller.toggleAmenities();
                          },
                          child: Text(
                            controller.amenities
                                ? MyStrings.viewLess.tr
                                : MyStrings.viewMore.tr,
                            style: tajawal14White400.copyWith(
                                color: Theme.of(context).primaryColor),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: List.generate(
                        controller.amenities
                            ? controller.amenitiesList.length
                            : controller.amenitiesList.length < 8
                                ? controller.amenitiesList.length
                                : 8,
                        (index) => GestureDetector(
                              onTap: () {
                                controller.setSelectedAmenities(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: .5,
                                        color:
                                            MyColor.colorBlack.withOpacity(.3)),
                                    color: controller
                                            .amenitiesList[index].isSelect
                                        ? MyColor.primaryColor.withOpacity(.5)
                                        : null),
                                child: Text(controller
                                    .amenitiesList[index].title
                                    .toString()
                                    .tr),
                              ),
                            )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
