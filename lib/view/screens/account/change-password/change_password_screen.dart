// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/account/change_password_controller.dart';
import 'package:booking_box/data/repo/account/change_password_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/screens/account/change-password/widget/change_password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ChangePasswordRepo(apiClient: Get.find()));
    Get.put(ChangePasswordController(changePasswordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ChangePasswordController>().clearData();
    });
  }

  @override
  void dispose() {
    Get.find<ChangePasswordController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        isShowBackBtn: true,
        title: MyStrings.changePassword.tr,
        bgColor: MyColor.colorWhite,
        titleColor: MyColor.colorWhite,
        iconColor: MyColor.primaryColor,
        isTitleCenter: true,
      ),
      body: Column(
        children: [
          Image.asset(
            "assets/images/logo/splash_logo.png",
            height: 154,
            width: 131,
            // fit: BoxFit.cover,
          ),
          GetBuilder<ChangePasswordController>(
            builder: (controller) => SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        MyStrings.createPasswordSubText.tr,
                        style: tajawal20White700.copyWith(
                            color: MyColor.colorBlack),
                      ),
                      const SizedBox(height: 25),
                      const ChangePasswordForm()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
