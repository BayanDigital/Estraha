import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/auth/auth/sms_verification_controler.dart';
import 'package:booking_box/data/repo/auth/sms_email_verification_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/buttons/rounded_button.dart';
import 'package:booking_box/view/components/buttons/rounded_loading_button.dart';
import 'package:booking_box/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:booking_box/view/components/text/small_text.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';

class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    final controller = Get.put(SmsVerificationController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.intData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          fromAuth: true,
          title: MyStrings.smsVerification.tr,
          isShowBackBtn: true,
          isShowActionBtn: false,
          titleColor: MyColor.colorWhite,
          iconColor: MyColor.colorWhite,
          bgColor: MyColor.getAppBarColor(),
        ),
        body: GetBuilder<SmsVerificationController>(
          builder: (controller) => controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: MyColor.getPrimaryColor()))
              : SingleChildScrollView(
                  padding: Dimensions.screenPaddingHV,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo/splash_logo.png",
                          height: 200,
                          width: 200,
                        ),
                        // const SizedBox(height: Dimensions.space50),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .07),
                          child: SmallText(
                              text: MyStrings.smsVerificationMsg.tr,
                              maxLine: 3,
                              textAlign: TextAlign.center,
                              textStyle: regularDefault.copyWith(
                                  color: MyColor.getLabelTextColor())),
                        ),
                        const SizedBox(height: 30),
                        OTPFieldWidget(onChanged: (value) {
                          controller.setCurrentText(value);
                        }),
                        const SizedBox(height: Dimensions.space30),
                        controller.submitLoading
                            ? const RoundedLoadingBtn()
                            : RoundedButton(
                                text: MyStrings.verify.tr,
                                press: () {
                                  controller
                                      .verifyYourSms(controller.currentText);
                                },
                              ),
                        const SizedBox(height: Dimensions.space30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(MyStrings.didNotReceiveCode.tr,
                                style: regularDefault.copyWith(
                                    color: MyColor.getLabelTextColor())),
                            const SizedBox(width: Dimensions.space10),
                            controller.resendLoading
                                ? Container(
                                    margin: const EdgeInsets.all(5),
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: MyColor.getPrimaryColor(),
                                    ))
                                : GestureDetector(
                                    onTap: () {
                                      controller.sendCodeAgain();
                                    },
                                    child: Text(MyStrings.resendCode.tr,
                                        style: regularDefault.copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            color: MyColor.getPrimaryColor()))),
                          ],
                        )
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
