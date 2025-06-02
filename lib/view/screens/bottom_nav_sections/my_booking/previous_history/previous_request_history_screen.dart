import 'package:booking_box/view/screens/bottom_nav_sections/my_booking/previous_history/widget/custom_no_previous_history.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/my_booking/my_booking_controller.dart';
import 'package:booking_box/view/components/divider/horizontal_divider.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/my_booking/previous_history/widget/reequest_room_bottom_sheet.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_loader/image_loader.dart';
import '../../../../components/divider/custom_divider.dart';
import '../../../../components/warning_aleart_dialog.dart';

class PreviousHistoryScreen extends StatefulWidget {
  const PreviousHistoryScreen({super.key});

  @override
  State<PreviousHistoryScreen> createState() => _PreviousHistoryScreenState();
}

class _PreviousHistoryScreenState extends State<PreviousHistoryScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<MyBookingController>().fetchNewBookingRequestData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<MyBookingController>().hasNextRequestBooking()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBookingController>(
      builder: (controller) => Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: Dimensions.space8),
            controller.isRequestLoading
                ? const Center(child: CustomLoader())
                : controller.requestBookingList.isEmpty
                    ? CustomNoPreviousHistory(
                        title: MyStrings.noPreviousTrips.tr,
                        subtitle:
                            "You may find inspiration for your next trip.".tr,
                      )
                    : Expanded(
                        child: SafeArea(
                          child: ListView.builder(
                            itemCount: controller.requestBookingList.length + 1,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              if (controller.requestBookingList.length ==
                                  index) {
                                return controller.hasNext()
                                    ? SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child:
                                              CustomLoader(isPagination: true),
                                        ),
                                      )
                                    : const SizedBox();
                              }

                              var bookingRequest =
                                  controller.requestBookingList[index];

                              return GestureDetector(
                                onTap: () {
                                  CustomBottomSheet(
                                      child: SafeArea(
                                          child: RequestRoomBottomSheet(
                                    bookingRequest: bookingRequest,
                                  ))).filterBottomSheet(context);
                                },
                                child: Container(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: CachedNetworkImage(
                                                    alignment: Alignment.center,
                                                    height: 90,
                                                    width: 80,
                                                    fit: BoxFit.fitHeight,
                                                    imageUrl: bookingRequest
                                                            .owner
                                                            ?.hotelSetting
                                                            ?.imageUrl ??
                                                        MyImages
                                                            .defaultImageNetwork,
                                                    placeholder: (context,
                                                            url) =>
                                                        const CustomImageLoader(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                const SizedBox(width: 11),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          bookingRequest
                                                                  .owner
                                                                  ?.hotelSetting
                                                                  ?.name
                                                                  ?.tr ??
                                                              '',
                                                          style: boldLarge.copyWith(
                                                              fontFamily:
                                                                  "Tajawal",
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .space6),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: Converter
                                                                    .formatNumber(
                                                                        bookingRequest.totalAmount ??
                                                                            '0'),
                                                                style: boldLarge.copyWith(
                                                                    fontFamily:
                                                                        "Tajawal",
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor)),
                                                            TextSpan(
                                                                text:
                                                                    " ${Get.find<ApiClient>().getCurrencyOrUsername().tr}",
                                                                style: boldLarge
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10)),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .space5),
                                                      MarqueeWidget(
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              MyImages.person,
                                                              width: Dimensions
                                                                  .space15,
                                                              height: Dimensions
                                                                  .space15,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                                '${bookingRequest.totalAdult} ${MyStrings.adults.tr}, ${bookingRequest.totalChild.toString().tr} ${MyStrings.children.tr}',
                                                                style: regularDefault.copyWith(
                                                                    fontFamily:
                                                                        "Tajawal",
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor)),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .space3),
                                                      MarqueeWidget(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                DateConverter.formatDateInEDayMonth(
                                                                        bookingRequest.checkIn ??
                                                                            '')
                                                                    .tr,
                                                                style: regularDefault.copyWith(
                                                                    fontFamily:
                                                                        "Tajawal",
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor)),
                                                            const HorizontalDivider(),
                                                            Text(
                                                                '${DateConverter.calculateNumberOfNights(bookingRequest.checkIn?.tr ?? '', bookingRequest.checkOut ?? '')} ${MyStrings.night.toTitleCase()}',
                                                                style: regularDefault.copyWith(
                                                                    fontFamily:
                                                                        "Tajawal",
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              const WarningAlertDialog()
                                                  .warningAlertDialog(
                                                      subtitleMessage: MyStrings
                                                          .deleteYourBooking.tr,
                                                      context, () {
                                                Navigator.pop(context);
                                                controller.cancelBookingRequest(
                                                    bookingRequest.id
                                                        .toString());
                                                controller
                                                    .setCurrentIndex(index);
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 11,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(.6),
                                                      width: .5)),
                                              child: controller
                                                          .isBookingCancelLoading &&
                                                      controller.currentIndex ==
                                                          index
                                                  ? const SizedBox(
                                                      height: 13,
                                                      width: 13,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: MyColor.colorRed,
                                                        strokeWidth: 2.5,
                                                      ))
                                                  : Text(
                                                      MyStrings.delete.tr,
                                                      style: regularDefault
                                                          .copyWith(
                                                              color: MyColor
                                                                  .colorRed,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                            ),
                                          )
                                        ],
                                      ),
                                      controller.requestBookingList.length -
                                                  1 ==
                                              index
                                          ? const SizedBox(
                                              height: Dimensions.space22,
                                            )
                                          : const CustomDivider(
                                              space: 18,
                                            )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
