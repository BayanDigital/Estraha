// ignore_for_file: deprecated_member_use

import 'package:booking_box/view/screens/bottom_nav_sections/my_booking/canceled_history/canceled_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/my_booking/my_booking_controller.dart';
import 'package:booking_box/data/repo/my_booking_repo.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/my_booking/current_history/current_history_screen.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/my_booking/previous_history/previous_request_history_screen.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../data/services/api_service.dart';

class MyBookingScreen extends StatefulWidget {
  final int bookingInitialTab;

  const MyBookingScreen({super.key, this.bookingInitialTab = 0});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MyBookingRepo(apiClient: Get.find()));
    final myBookingController =
        Get.put(MyBookingController(myBookingRepo: Get.find()));
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myBookingController.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColor.primaryColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));

    return GetBuilder<MyBookingController>(
      builder: (controller) => WillPopWidget(
        isNeedToGoBottomNav: true,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: controller.isLoading
              ? const CustomLoader()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Text(
                          MyStrings.yourTrips.tr,
                          style: tajawal20White700.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.space20,
                          vertical: Dimensions.space22),
                      child: TabBar(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        splashFactory: NoSplash.splashFactory,
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                        indicator: const BoxDecoration(),
                        indicatorPadding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        tabs: [
                          Tab(
                            child: Container(
                              width: 120,
                              height: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: tabController?.index == 0
                                    ? const Color(0xff614a3e).withOpacity(0.7)
                                    : Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: MarqueeWidget(
                                  child: Text(
                                    MyStrings.current.tr,
                                    style: tajawal15PrimaryColor500.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: 120,
                              height: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: tabController?.index == 1
                                    ? const Color(0xff614a3e).withOpacity(0.8)
                                    : Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: MarqueeWidget(
                                  child: Text(
                                    MyStrings.previous.tr,
                                    style: tajawal15PrimaryColor500.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: 120,
                              height: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: tabController?.index == 2
                                    ? const Color(0xff614a3e).withOpacity(0.8)
                                    : Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: MarqueeWidget(
                                  child: Text(
                                    MyStrings.canceled.tr,
                                    style: tajawal15PrimaryColor500.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        onTap: (_) {
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: const [
                          CurrentHistoryScreen(),
                          PreviousHistoryScreen(),
                          CanceledHistoryScreen(),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
