import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/home/home_controller.dart';
import '../../../../components/snack_bar/show_custom_snackbar.dart';
import 'custom_header.dart';

class FeaturedHotelSection extends StatelessWidget {
  final HomeController controller;
  final bool isShowHeading;
  final int numberOfCardShowing;

  const FeaturedHotelSection(
      {super.key,
      required this.controller,
      this.isShowHeading = true,
      this.numberOfCardShowing = 2});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isShowHeading)
            CustomHeader(
              title: MyStrings.featuredHotel.tr,
              isShowSeeMoreButton: controller.featuredHotelList.length <
                  controller.totalFeaturedOwner,
              actionPress: () {
                Get.toNamed(RouteHelper.featuredHotelScreen);
              },
            ),
          if (controller.featuredHotelList.isEmpty)
            const SizedBox.shrink()
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                child: Row(
                  children: List.generate(
                      controller.featuredHotelList.length * 2 - 1, (index) {
                    if (index.isOdd) {
                      return const SizedBox(width: 10);
                    }

                    final hotelIndex = index ~/ 2;
                    var hotelSettings =
                        controller.featuredHotelList[hotelIndex].hotelSetting;

                    return GestureDetector(
                      onTap: () {
                        if (controller.checkOutDate == MyStrings.checkOutDate ||
                            controller.checkOutDate == MyStrings.startDate) {
                          CustomSnackBar.error(
                              errorList: [MyStrings.selectCheckOut.tr]);
                        } else {
                          Get.toNamed(RouteHelper.hotelDetailsScreen,
                              arguments: hotelSettings?.ownerId.toString());
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.amberAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CustomCashNetworkImage(
                                      imageHeight: size.height * .14,
                                      imageWidth: 250,
                                      imageUrl: hotelSettings?.imageUrl ?? '',
                                    )),
                              ],
                            ),
                            const SizedBox(height: Dimensions.space16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(hotelSettings?.name.toString().tr ?? '',
                                      style: semiBoldLarge.copyWith(
                                        fontFamily: "Tajawal",
                                        color: Theme.of(context).primaryColor,
                                      )),
                                  Text(
                                    '${hotelSettings?.starRating?.tr ?? ''} ${'Stars'.tr}',
                                    style: semiBoldLarge.copyWith(
                                      fontFamily: "Tajawal",
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimensions.space8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    MyImages.location,
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context).primaryColor,
                                        BlendMode.srcIn),
                                  ),
                                  const SizedBox(width: Dimensions.space8),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          hotelSettings?.hotelAddress
                                                  .toString()
                                                  .tr ??
                                              '',
                                          style: regularDefault.copyWith(
                                            fontFamily: "Tajawal",
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${hotelSettings?.upcomingCheckinDays?.tr ?? ''} ${'days'.tr}',
                                          style: regularDefault.copyWith(
                                            fontFamily: "Tajawal",
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )
        ],
      ),
    );
  }
}
