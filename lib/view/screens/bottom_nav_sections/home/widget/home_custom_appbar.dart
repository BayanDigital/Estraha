import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCustomAppbar extends StatelessWidget {
  const HomeCustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.190,
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: MyColor.primaryColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.start,
            MyStrings.yourLocation.tr,
            style: tajawal24White500.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.editProfileScreen);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.location_on_outlined,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            size: 20),
                      ),
                    ),

                    // const SizedBox(width: 12),
                    Expanded(
                        child: Text(
                      controller.siteName.tr,
                      // textAlign: TextAlign.start,
                      style: tajawal14White400,
                    ))
                  ],
                ),
              ),
              SizedBox(
                width: 25,
                height: 25,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.notificationScreen);
                  },
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 26,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.searchScreen);
                },
                child: Container(
                  height: 40,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(Icons.search_rounded,
                            color: MyColor.primaryColor, size: 22),
                      ),
                      Text(
                        "Find your favorite city".tr,
                        style: tajawal14White400.copyWith(
                            color: MyColor.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.filterScreen);
                },
                child: Icon(Icons.tune_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor, size: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
