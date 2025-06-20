import 'package:booking_box/view/screens/notification_screen/widget/custom_no_notifications.dart';
import 'package:booking_box/view/screens/notification_screen/widget/notification_details_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';

import '../../../data/controller/notification/notification_controller.dart';
import '../../../data/repo/notificaton_repo/notification_repo.dart';
import '../../../data/services/api_service.dart';
import '../../components/bottom-sheet/custom_bottom_sheet.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<NotificationsController>().initData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<NotificationsController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColor.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(NotificationRepo(apiClient: Get.find()));
    final controller = Get.put(NotificationsController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      builder: (controller) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                decoration: const BoxDecoration(
                    color: MyColor.primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Center(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: MyColor.colorWhite,
                              size: 20,
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          MyStrings.notification.tr,
                          style: tajawal20White700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 180,
              ),
              Center(
                child: controller.isLoading
                    ? const CustomLoader()
                    : controller.notificationList.isEmpty
                        ? Center(
                            child: CustomNoNotificationsWidget(
                            title: MyStrings.noNotificationFound.tr,
                          ))
                        : RefreshIndicator(
                            color: MyColor.primaryColor,
                            backgroundColor: MyColor.colorWhite,
                            onRefresh: () async {
                              controller.page = 0;
                              await controller.initData();
                            },
                            child: SafeArea(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.space16),
                                    itemCount:
                                        controller.notificationList.length + 1,
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if (controller.notificationList.length ==
                                          index) {
                                        return controller.hasNext()
                                            ? SizedBox(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: const Center(
                                                  child: CustomLoader(
                                                      isPagination: true),
                                                ),
                                              )
                                            : const SizedBox();
                                      }

                                      return GestureDetector(
                                        onTap: () {
                                          CustomBottomSheet(
                                              child: SafeArea(
                                                  child:
                                                      NotificationDetailsBottomSheet(
                                            notification: controller
                                                .notificationList[index],
                                          ))).filterBottomSheet(context);
                                        },
                                        child: Container(
                                          width: context.width,
                                          decoration: BoxDecoration(
                                              color: MyColor.colorWhite,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.space5)),
                                          padding: const EdgeInsets.all(
                                              Dimensions.space16),
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.space8,
                                              top: index == 0 ? 12 : 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateConverter
                                                    .getFormatedSubtractTime(
                                                        controller
                                                                .notificationList[
                                                                    index]
                                                                .createdAt
                                                                .toString()
                                                                .tr ??
                                                            ''),
                                                style: mediumDefault,
                                              ),
                                              const SizedBox(
                                                height: Dimensions.space4,
                                              ),
                                              Text(
                                                controller
                                                        .notificationList[index]
                                                        .subject
                                                        ?.tr ??
                                                    '',
                                                style: boldLarge,
                                              ),
                                              const SizedBox(
                                                height: Dimensions.space7,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
