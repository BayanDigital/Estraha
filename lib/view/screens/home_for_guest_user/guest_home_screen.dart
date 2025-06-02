import 'dart:async';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/repo/home/home_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/home/widget/featuren_hotel_section.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/home/widget/popular_city_section.dart';
import 'package:booking_box/view/screens/home_for_guest_user/widget/guest_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:get/get.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller = Get.put(
        HomeController(homeRepo: Get.find(), permanent: true),
        permanent: true);
    return WillPopWidget(
      nextRoute: "",
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: _isLoading
              ? const Center(child: CustomLoader())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const GuestScreenAppbar(),
                      const PopularCitySection(),
                      FeaturedHotelSection(controller: controller)
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
                      // SizedBox(
                      //     height: MediaQuery.of(context).size.height * 0.17),
                      // Image.asset("assets/images/previousHistory.png",
                      //     width: 250, fit: BoxFit.cover),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // GestureDetector(
                      //     onTap: () {
                      //       Get.toNamed("/login_screen");
                      //     },
                      //     child: const GuestData())