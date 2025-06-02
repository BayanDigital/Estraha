// ignore_for_file: deprecated_member_use

import 'package:booking_box/core/utils/util.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/my_booking/current_history/widgets/custom_no_current_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/my_booking/my_booking_controller.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/screens/booking_details/booking_details_screen.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/my_booking/widget/booking_status_widget.dart';

import '../../../../../core/utils/style.dart';
import '../../../../../data/repo/my_booking_repo.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/app-bar/custom_appbar.dart';
import '../../../deposits/payment/complement_payment.dart';

class CurrentHistoryScreen extends StatefulWidget
    implements PreferredSizeWidget {
  final bool isShowAppBar;

  const CurrentHistoryScreen({super.key, this.isShowAppBar = false});

  @override
  State<CurrentHistoryScreen> createState() => _BookingHistoryScreenState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _BookingHistoryScreenState extends State<CurrentHistoryScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<MyBookingController>().fetchNewBookingData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<MyBookingController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isShowAppBar) {
      init();
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(_scrollListener);
    });
  }

  void init() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MyBookingRepo(apiClient: Get.find()));
    final myBookingController =
        Get.put(MyBookingController(myBookingRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myBookingController.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<MyBookingController>(
      builder: (controller) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: widget.isShowAppBar
              ? CustomAppBar(
                  isTitleCenter: true,
                  isShowElevation: true,
                  bgColor: MyColor.colorWhite,
                  title: MyStrings.myBookings.tr,
                  statusBarColor: MyColor.colorWhite,
                  titleColor: MyColor.colorBlack,
                )
              : null,
          body: controller.isLoading
              ? const CustomLoader()
              : controller.bookingHistoryList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomNoCurrentHistory(
                        title: MyStrings.noCurrentTrips,
                        subtitle:
                            "When you make a booking, your trip details will appear here"
                                .tr,
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: controller.bookingHistoryList.length + 1,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (controller.bookingHistoryList.length == index) {
                          return controller.hasNext()
                              ? SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: const Center(
                                    child: CustomLoader(isPagination: true),
                                  ),
                                )
                              : const SizedBox();
                        }

                        return GestureDetector(
                          onTap: () => Get.to(BookingDetailsScreen(
                            id: controller.bookingHistoryList[index].id ?? '-1',
                          )),
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 18,
                                  right: 18,
                                  bottom: 12,
                                  top: widget.isShowAppBar ? 15 : 5),
                              width: size.width,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                                  borderRadius: BorderRadius.circular(8),
                                  border: const Border(
                                      top: BorderSide(
                                          color: MyColor.darkBlue, width: .1),
                                      bottom: BorderSide(
                                          color: MyColor.darkBlue, width: .1))),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: MyColor.skyBlue),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            ShaderMask(
                                                shaderCallback: (rect) {
                                                  return LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(1),
                                                      Colors.transparent
                                                    ],
                                                  ).createShader(Rect.fromLTRB(
                                                      0,
                                                      0,
                                                      rect.width,
                                                      rect.height));
                                                },
                                                blendMode: BlendMode.darken,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8)),
                                                  child: CustomCashNetworkImage(
                                                    imageWidth: size.width,
                                                    imageHeight: 180,
                                                    imageUrl:
                                                        '${controller.bookingHistoryList[index].owner?.hotelSetting?.ImageUrl}',
                                                    loaderImage:
                                                        MyImages.defaultImage,
                                                  ),
                                                )),
                                            Positioned(
                                              top: 10,
                                              left: 10,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                    color: MyColor.skyBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      MyImages.hotel,
                                                      width: 10,
                                                      height: 10,
                                                    ),
                                                    const SizedBox(
                                                        width:
                                                            Dimensions.space6),
                                                    Text(
                                                      MyStrings.hotel.tr,
                                                      style: boldDefault.copyWith(
                                                          color: MyColor
                                                              .titleTextColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: HistoryStatusWidget(
                                                  status: controller
                                                      .getBookingStatus(controller
                                                              .bookingHistoryList[
                                                          index])),
                                            ),
                                            Positioned(
                                              top: 80,
                                              left: MyUtils.isRtl(context)
                                                  ? null
                                                  : 10,
                                              right: MyUtils.isRtl(context)
                                                  ? 10
                                                  : null,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                "${MyStrings.bookingId.tr}:",
                                                            style: regularDefault.copyWith(
                                                                color: MyColor
                                                                    .colorWhite
                                                                    .withOpacity(
                                                                        .8))),
                                                        TextSpan(
                                                            text:
                                                                " ${controller.bookingHistoryList[index].bookingNumber?.tr ?? ''}",
                                                            style: boldDefault
                                                                .copyWith(
                                                                    color: MyColor
                                                                        .colorWhite)),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space6),
                                                  Text(
                                                    controller
                                                            .bookingHistoryList[
                                                                index]
                                                            .owner
                                                            ?.hotelSetting
                                                            ?.name
                                                            ?.tr ??
                                                        '',
                                                    style: boldLarge.copyWith(
                                                        color:
                                                            MyColor.colorWhite),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space6),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SvgPicture.asset(
                                                          MyImages.location,
                                                          colorFilter:
                                                              const ColorFilter
                                                                  .mode(
                                                            MyColor
                                                                .bodyTextColor,
                                                            BlendMode.srcIn,
                                                          )),
                                                      const SizedBox(
                                                        width:
                                                            Dimensions.space6,
                                                      ),
                                                      SizedBox(
                                                          width: size.width,
                                                          child: Text(
                                                            controller
                                                                    .bookingHistoryList[
                                                                        index]
                                                                    .owner
                                                                    ?.hotelSetting
                                                                    ?.hotelAddress
                                                                    ?.tr ??
                                                                '',
                                                            style: boldDefault
                                                                .copyWith(
                                                                    color: MyColor
                                                                        .bodyTextColor,
                                                                    fontSize:
                                                                        14),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space6),
                                                  Container(
                                                    width: size.width - 40,
                                                    color: Colors.black,
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "${MyStrings.checkIN.tr}:",
                                                                style: regularDefault.copyWith(
                                                                    color: MyColor
                                                                        .colorWhite
                                                                        .withOpacity(
                                                                            .8))),
                                                            Text(
                                                              ' ${DateConverter.formatDateYearPunctuation(controller.bookingHistoryList[index].checkIn?.tr ?? '')}',
                                                              style: boldDefault
                                                                  .copyWith(
                                                                      color: MyColor
                                                                          .colorWhite),
                                                            ),
                                                          ],
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      6),
                                                          child: Icon(
                                                            Icons
                                                                .fiber_manual_record,
                                                            size: 10,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  "${MyStrings.checkOUT.tr}:",
                                                                  style: regularDefault.copyWith(
                                                                      color: MyColor
                                                                          .colorWhite
                                                                          .withOpacity(
                                                                              .8))),
                                                              Expanded(
                                                                  child:
                                                                      MarqueeWidget(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                        " ${DateConverter.formatDateYearPunctuation(controller.bookingHistoryList[index].checkOut?.tr ?? '')}",
                                                                        style: boldDefault.copyWith(
                                                                            color:
                                                                                MyColor.colorWhite)),
                                                                  ],
                                                                ),
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Converter.formatNumber(controller
                                                              .bookingHistoryList[
                                                                  index]
                                                              .dueAmount ??
                                                          '0') ==
                                                      '0.00'
                                                  ? Expanded(
                                                      child: Text(
                                                          MyStrings
                                                              .theFullAmountHasBeenPaid
                                                              .tr,
                                                          style: boldLarge.copyWith(
                                                              color: MyColor
                                                                  .primaryColor,
                                                              fontSize:
                                                                  size.height *
                                                                      .016)),
                                                    )
                                                  : Expanded(
                                                      child: Text(
                                                        "${MyStrings.dueAmount.tr} : "
                                                        "${controller.myBookingRepo.apiClient.getCurrencyOrUsername(isSymbol: true)}"
                                                        "${Converter.formatNumber(controller.bookingHistoryList[index].dueAmount ?? '0')}",
                                                        style:
                                                            boldLarge.copyWith(
                                                                color: MyColor
                                                                    .colorBlack,
                                                                fontSize:
                                                                    size.height *
                                                                        .016),
                                                      ),
                                                    ),
                                              Converter.formatNumber(controller
                                                              .bookingHistoryList[
                                                                  index]
                                                              .dueAmount ??
                                                          '0') ==
                                                      '0.00'
                                                  ? const SizedBox.shrink()
                                                  : Column(
                                                      children: [
                                                        // const SizedBox(height: Dimensions.space10),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.to(
                                                                CompletePaymentScreen(
                                                              bookingId: controller
                                                                      .bookingHistoryList[
                                                                          index]
                                                                      .id ??
                                                                  '-1',
                                                            ));
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color: MyColor
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Text(
                                                              MyStrings
                                                                  .completePayment
                                                                  .tr,
                                                              style: boldDefault
                                                                  .copyWith(
                                                                      color: MyColor
                                                                          .colorWhite),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 14,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    )),
    );
  }
}
