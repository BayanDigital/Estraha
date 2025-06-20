// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/auth/forget_password/reset_password_controller.dart';
import 'package:booking_box/data/repo/auth/login_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/buttons/rounded_button.dart';
import 'package:booking_box/view/components/buttons/rounded_loading_button.dart';
import 'package:booking_box/view/components/text-form-field/custom_text_field.dart';
import 'package:booking_box/view/components/text/default_text.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:booking_box/view/screens/auth/registration/widget/validation_widget.dart';

import '../../../../components/app-bar/custom_appbar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(ResetPasswordController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.email = Get.arguments[0];
      controller.code = Get.arguments[1];
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
          title: MyStrings.resetPassword.tr,
          fromAuth: true,
          bgColor: MyColor.getAppBarColor(),
          titleColor: MyColor.colorWhite,
          iconColor: MyColor.colorWhite,
        ),
        body: GetBuilder<ResetPasswordController>(
          builder: (controller) => SingleChildScrollView(
            padding: Dimensions.screenPaddingHV,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo/splash_logo.png',
                    width: 200,
                    height: 193,
                  ),
                  DefaultText(
                    text: MyStrings.resetPassContent.tr,
                    textStyle: regularDefault.copyWith(
                        color: MyColor.getTextColor().withOpacity(0.8)),
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Focus(
                    onFocusChange: (hasFocus) {
                      controller.changePasswordFocus(hasFocus);
                    },
                    child: CustomTextField(
                        animatedLabel: true,
                        needOutlineBorder: true,
                        focusNode: controller.passwordFocusNode,
                        nextFocus: controller.confirmPasswordFocusNode,
                        labelText: MyStrings.password,
                        leadingIcon: MyImages.passwordSvg,
                        isShowSuffixIcon: true,
                        isPassword: true,
                        textInputType: TextInputType.text,
                        controller: controller.passController,
                        validator: (value) {
                          return controller.validatePassword(value);
                        },
                        onChanged: (value) {
                          if (controller.checkPasswordStrength) {
                            controller.updateValidationList(value);
                          }
                          return;
                        }),
                  ),
                  Visibility(
                      visible: controller.hasPasswordFocus &&
                          controller.checkPasswordStrength,
                      child: ValidationWidget(
                        list: controller.passwordValidationRules,
                        fromReset: true,
                      )),
                  const SizedBox(height: Dimensions.space15),
                  CustomTextField(
                    animatedLabel: true,
                    needOutlineBorder: true,
                    inputAction: TextInputAction.done,
                    isPassword: true,
                    leadingIcon: MyImages.passwordSvg,
                    labelText: MyStrings.confirmPassword.tr,
                    hintText: MyStrings.confirmYourPassword.tr,
                    isShowSuffixIcon: true,
                    controller: controller.confirmPassController,
                    onChanged: (value) {
                      return;
                    },
                    validator: (value) {
                      if (controller.passController.text.toLowerCase() !=
                          controller.confirmPassController.text.toLowerCase()) {
                        return MyStrings.kMatchPassError.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.space35),
                  controller.submitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                          text: MyStrings.submit.tr,
                          press: () {
                            if (formKey.currentState!.validate()) {
                              controller.resetPassword();
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
