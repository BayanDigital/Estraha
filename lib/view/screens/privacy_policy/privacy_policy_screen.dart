// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/privacy/privacy_controller.dart';
import 'package:booking_box/data/repo/privacy_repo/privacy_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/buttons/category_button.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PrivacyRepo(apiClient: Get.find()));
    final controller = Get.put(PrivacyController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          isTitleCenter: true,
          title: MyStrings.policies.tr,
          bgColor: MyColor.colorWhite,
          titleColor: MyColor.colorBlack,
          iconColor: MyColor.colorBlack,
          isShowElevation: true,
          isShowActionBtn: false,
        ),
        body: GetBuilder<PrivacyController>(
          builder: (controller) => SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: controller.isLoading
                  ? const CustomLoader()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.space8),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/logo/splash_logo.png",
                            height: 138,
                            width: 118,
                            // fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.space10, top: 0),
                          child: SizedBox(
                            height: 30,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  controller.list.length,
                                  (index) => Row(
                                    children: [
                                      CategoryButton(
                                          color:
                                              controller.selectedIndex == index
                                                  ? MyColor.primaryColor
                                                  : MyColor.primaryColor
                                                      .withOpacity(0.20),
                                          horizontalPadding: 8,
                                          verticalPadding: 7,
                                          textColor:
                                              controller.selectedIndex == index
                                                  ? MyColor.colorWhite
                                                  : MyColor.colorBlack,
                                          text: controller
                                              .list[index].dataValues.title.tr,
                                          press: () {
                                            controller.changeIndex(index);
                                          }),
                                      const SizedBox(width: Dimensions.space10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        Expanded(
                            child: Center(
                          child: SingleChildScrollView(
                              child: Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        MyColor.primaryColor.withOpacity(0.15),
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                child: HtmlWidget(controller.selectedHtml,
                                    textStyle: regularDefault.copyWith(
                                        color: Theme.of(context).primaryColor),
                                    onLoadingBuilder: (context, element,
                                            loadingProgress) =>
                                        const Center(child: CustomLoader()))),
                          )),
                        ))
                      ],
                    ),
            ),
          ),
        ));
  }
}
