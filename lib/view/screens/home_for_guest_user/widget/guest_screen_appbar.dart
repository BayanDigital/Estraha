import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestScreenAppbar extends StatelessWidget {
  const GuestScreenAppbar({super.key});
  void _redirectToLogin() {
    Get.toNamed('/login_screen');
  }

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              textAlign: TextAlign.start,
              "Welcome".tr,
              style: tajawal24White500.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
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
                        // height: 25,
                        // width: 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Row(
                            children: [
                              Text(
                                "Log in now and order and book with ease".tr,
                                style: tajawal14White400.copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.09),
                              InkWell(
                                onTap: () {
                                  _redirectToLogin();
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(.14)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                        'assets/images/guest_login.png',
                                        height: 30,
                                        width: 30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
