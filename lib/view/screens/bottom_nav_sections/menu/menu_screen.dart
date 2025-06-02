// ignore_for_file: deprecated_member_use

import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/core/utils/util.dart';
import 'package:booking_box/data/controller/account/profile_controller.dart';
import 'package:booking_box/data/controller/localization/localization_controller.dart';
import 'package:booking_box/data/controller/menu/my_menu_controller.dart';
import 'package:booking_box/data/repo/account/profile_repo.dart';
import 'package:booking_box/data/repo/auth/general_setting_repo.dart';
import 'package:booking_box/data/repo/menu_repo/menu_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/divider/custom_divider.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/menu/widget/menu_item.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/my_booking/current_history/current_history_screen.dart';

import '../../../components/warning_aleart_dialog.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    Get.put(ProfileController(profileRepo: Get.find()));
    final controller =
        Get.put(MyMenuController(menuRepo: Get.find(), repo: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: MyColor.colorWhite,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark),
      child: GetBuilder<LocalizationController>(
        builder: (localizationController) => GetBuilder<MyMenuController>(
          builder: (menuController) => WillPopWidget(
            // nextRoute: RouteHelper.bottomNavBar,
            isNeedToGoBottomNav: true,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                centerTitle: true,
                title: Text(
                  MyStrings.account.tr,
                  style: regularLargeTajawal.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: GetBuilder<MyMenuController>(
                builder: (controller) => Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: size.height * .026,
                              left: 16,
                              right: 16,
                              bottom: 16),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Image.asset(MyImages.profile,
                                    height: 100,
                                    color: Theme.of(context).primaryColor),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    Get.find<HomeController>().name.tr,
                                    style: regularLargeTajawal.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // const SizedBox(
                                  //   width: 5,
                                  // ),
                                  // Text(
                                  //   Get.find<HomeController>().username.tr,
                                  //   style: regularLargeTajawal.copyWith(
                                  //       color: MyColor.colorBlack,
                                  //       fontSize: 23,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.space15,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.defaultRadius),
                              ),
                              child: Column(
                                children: [
                                  MenuItems(
                                    imageSrc: MyImages.person,
                                    label: MyStrings.profile.tr,
                                    iconOpacity: 1,
                                    onPressed: () => Get.toNamed(
                                        RouteHelper.editProfileScreen),
                                  ),
                                  controller.menuRepo.apiClient
                                                  .sharedPreferences
                                                  .getString(
                                                      SharedPreferenceHelper
                                                          .socialId) !=
                                              null &&
                                          controller.menuRepo.apiClient
                                              .sharedPreferences
                                              .getString(SharedPreferenceHelper
                                                  .socialId)!
                                              .isNotEmpty
                                      ? const SizedBox.shrink()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const CustomDivider(
                                              space: Dimensions.space10,
                                              color: MyColor.transparentColor,
                                            ),
                                            MenuItems(
                                              imageSrc: MyImages.lock,
                                              iconOpacity: 1,
                                              label: MyStrings.changePassword,
                                              onPressed: () => Get.toNamed(
                                                  RouteHelper
                                                      .changePasswordScreen),
                                            ),
                                          ],
                                        ),
                                  const CustomDivider(
                                    space: Dimensions.space10,
                                    color: MyColor.transparentColor,
                                  ),
                                  MenuItems(
                                    imageSrc: MyImages.history,
                                    label: MyStrings.myBookings.tr,
                                    iconOpacity: 1,
                                    onPressed: () {
                                      Get.to(const CurrentHistoryScreen(
                                          isShowAppBar: true));
                                    },
                                  ),
                                  const CustomDivider(
                                    space: Dimensions.space10,
                                    color: MyColor.transparentColor,
                                  ),
                                  MenuItems(
                                    imageSrc: MyImages.paymentLog,
                                    label: MyStrings.paymentHistory.tr,
                                    iconOpacity: 1,
                                    onPressed: () {
                                      Get.toNamed(RouteHelper.paymentLogScreen);
                                    },
                                  ),
                                  const CustomDivider(
                                    space: Dimensions.space10,
                                    color: MyColor.transparentColor,
                                  ),
                                  MenuItems(
                                    imageSrc: MyImages.bell,
                                    label: MyStrings.notificationLog.tr,
                                    iconOpacity: 1,
                                    onPressed: () {
                                      Get.toNamed(
                                          RouteHelper.notificationScreen);
                                    },
                                  ),
                                ],
                              ),
                            ),

                            // const SizedBox(height: Dimensions.space13),
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: CustomDivider()),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.space15,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.defaultRadius),
                                boxShadow: MyUtils.getCardShadow(),
                              ),
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: Get.find<ApiClient>()
                                            .getGSData()
                                            .data
                                            ?.generalSetting
                                            ?.multiLanguage ==
                                        1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MenuItems(
                                          isSvgImage: true,
                                          imageSrc:
                                              "assets/images/themeMode.svg",
                                          label: "Theme",
                                          onPressed: () {
                                            Get.toNamed(
                                                RouteHelper.themeScreen);
                                          },
                                        ),
                                        const CustomDivider(
                                          space: Dimensions.space10,
                                          color: MyColor.transparentColor,
                                        ),
                                        MenuItems(
                                          imageSrc: MyImages.language,
                                          label: MyStrings.language.tr,
                                          iconOpacity: 1,
                                          onPressed: () {
                                            Get.toNamed(
                                                RouteHelper.languageScreen);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Get.find<ApiClient>()
                                              .getGSData()
                                              .data
                                              ?.generalSetting
                                              ?.multiLanguage ==
                                          1
                                      ? const CustomDivider(
                                          space: Dimensions.space10,
                                          color: MyColor.transparentColor,
                                        )
                                      : const SizedBox.shrink(),
                                  MenuItems(
                                    imageSrc: MyImages.support,
                                    label: MyStrings.supportTicket.tr,
                                    iconOpacity: 1,
                                    onPressed: () {
                                      Get.toNamed(RouteHelper.allTicketScreen);
                                    },
                                  ),
                                  const CustomDivider(
                                    space: Dimensions.space10,
                                    color: MyColor.transparentColor,
                                  ),
                                  MenuItems(
                                    imageSrc: MyImages.policy,
                                    label: MyStrings.policies.tr,
                                    iconOpacity: 1,
                                    onPressed: () {
                                      Get.toNamed(RouteHelper.privacyScreen);
                                    },
                                  ),
                                  const CustomDivider(
                                    space: Dimensions.space10,
                                    color: MyColor.transparentColor,
                                  ),
                                  MenuItems(
                                    imageSrc: MyImages.faq,
                                    label: MyStrings.faq.tr,
                                    iconOpacity: 1,
                                    onPressed: () {
                                      Get.toNamed(RouteHelper.faqScreen);
                                    },
                                  ),
                                  Get.find<HomeController>().provider ==
                                          MyStrings.google
                                      ? const SizedBox.shrink()
                                      : const CustomDivider(
                                          space: Dimensions.space10,
                                          color: MyColor.transparentColor,
                                        ),
                                  Get.find<HomeController>().provider ==
                                          MyStrings.google
                                      ? const SizedBox.shrink()
                                      : MenuItems(
                                          imageSrc: MyImages.delete,
                                          label: MyStrings.deleteAccount.tr,
                                          color: MyColor.colorRed,
                                          titleColor: MyColor.colorRed,
                                          iconOpacity: 1,
                                          onPressed: () {
                                            const WarningAlertDialog()
                                                .warningAlertDialog(
                                              subtitleMessage:
                                                  MyStrings.youWantToDelete.tr,
                                              isDelete: true,
                                              context,
                                              () {
                                                Navigator.pop(context);
                                                controller.deleteAccount();
                                              },
                                            );
                                          },
                                        ),
                                ],
                              ),
                            ),

                            // const SizedBox(height: Dimensions.space13),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: CustomDivider(
                                space: Dimensions.space10,
                                color: MyColor.transparentColor,
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.space10,
                                horizontal: Dimensions.space15,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.defaultRadius),
                                // boxShadow: MyUtils.getCardShadow()
                              ),
                              child: controller.logoutLoading
                                  ? const Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: MyColor.primaryColor,
                                          strokeWidth: 2.00,
                                        ),
                                      ),
                                    )
                                  : MenuItems(
                                      imageSrc: MyImages.logout,
                                      iconOpacity: 1,
                                      label: MyStrings.logout.tr,
                                      onPressed: () {
                                        const WarningAlertDialog()
                                            .warningAlertDialog(
                                          subtitleMessage:
                                              MyStrings.youWantToLogout.tr,
                                          context,
                                          () {
                                            Navigator.pop(context);
                                            controller.logout();
                                          },
                                        );
                                      },
                                    ),
                            ),

                            const SizedBox(
                              height: 60,
                            ),
                            // const SizedBox(height: Dimensions.space60 + 30)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
