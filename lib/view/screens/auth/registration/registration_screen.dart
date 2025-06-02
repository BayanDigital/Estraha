import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/auth/auth/registration_controller.dart';
import 'package:booking_box/data/controller/auth/login_controller.dart';
import 'package:booking_box/data/repo/auth/general_setting_repo.dart';
import 'package:booking_box/data/repo/auth/signup_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/custom_no_data_found_class.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:booking_box/view/screens/auth/registration/widget/registration_form.dart';

import '../../../../data/repo/auth/login_repo.dart';

class RegistrationScreen extends StatefulWidget {
  final bool isFromOnboard;

  const RegistrationScreen({Key? key, this.isFromOnboard = false})
      : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(
        registrationRepo: Get.find(), generalSettingRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  initialLogin() {}

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => WillPopWidget(
        nextRoute: RouteHelper.loginScreen,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: controller.noInternet
              ? NoDataOrInternetScreen(
                  isNoInternet: true,
                  onChanged: (value) {
                    controller.changeInternet(value);
                  },
                )
              : controller.isLoading
                  ? const CustomLoader()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          // vertical: Dimensions.space5,
                          horizontal: Dimensions.space16),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  // SizedBox(
                                  //     height:
                                  //         MediaQuery.of(context).size.height *
                                  //             .09),
                                  // Text(
                                  //   controller.registrationRepo.apiClient
                                  //       .getSiteName(),
                                  //   style: semiBoldOverLargeManrope.copyWith(
                                  //       fontSize: 24,
                                  //       color: MyColor.titleTextColor),
                                  // ),
                                  // const SizedBox(height: 8),

                                  Image.asset(
                                    'assets/images/logo/splash_logo.png',
                                    height: 193,
                                    width: 165,
                                  ),
                                  Text(
                                    MyStrings.createAnAccount.tr,
                                    style: regularLargeTajawal.copyWith(
                                        color: MyColor.primaryTextColor,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .02),
                            const RegistrationForm(),
                            // const SizedBox(height: Dimensions.space16),
                            // const SocialLoginSection(),
                            const SizedBox(height: Dimensions.space22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(MyStrings.alreadyAccount.tr,
                                    style: regularLargeTajawal.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: "Tajawal",
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(width: Dimensions.space3),
                                TextButton(
                                  onPressed: () {
                                    controller.clearAllData();
                                    Get.offAndToNamed(RouteHelper.loginScreen);
                                  },
                                  child: Text(MyStrings.signIn.tr,
                                      style: regularLargeTajawal.copyWith(
                                          color: MyColor.getPrimaryColor())),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
