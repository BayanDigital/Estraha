import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/auth/auth/registration_controller.dart';
import 'package:booking_box/view/components/text-form-field/custom_text_field.dart';
import 'package:booking_box/view/screens/auth/registration/widget/validation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/buttons/gradient_rounded_button.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  bool isNumberBlank = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                borderRadius: Dimensions.inputFieldBorderRadius,
                leadingIcon: MyImages.userSvg,
                fillColor: MyColor.textFieldColor,
                labelText: MyStrings.name.tr,
                controller: controller.fNameController,
                focusNode: controller.firstNameFocusNode,
                textInputType: TextInputType.text,
                nextFocus: controller.lastNameFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.enterYourFirstName.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),

              const SizedBox(height: Dimensions.space20),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                fillColor: MyColor.textFieldColor,
                labelText: MyStrings.email.tr,
                leadingIcon: MyImages.emailSvg,
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                textInputType: TextInputType.emailAddress,
                borderRadius: Dimensions.inputFieldBorderRadius,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return MyStrings.enterYourEmail.tr;
                  } else if (!MyStrings.emailValidatorRegExp
                      .hasMatch(value ?? '')) {
                    return MyStrings.invalidEmailMsg.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: Dimensions.space20),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                borderRadius: Dimensions.inputFieldBorderRadius,
                leadingIcon: MyImages.userSvg,
                fillColor: MyColor.textFieldColor,
                labelText: MyStrings.phone.tr,
                controller: controller.lNameController,
                focusNode: controller.lastNameFocusNode,
                textInputType: TextInputType.text,
                nextFocus: controller.emailFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.enterYourLastName.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: Dimensions.space20),
              Focus(
                  onFocusChange: (hasFocus) {
                    controller.changePasswordFocus(hasFocus);
                  },
                  child: CustomTextField(
                    animatedLabel: true,
                    needOutlineBorder: true,
                    isShowSuffixIcon: true,
                    isPassword: true,
                    leadingIcon: MyImages.passwordSvg,
                    borderRadius: Dimensions.inputFieldBorderRadius,
                    fillColor: MyColor.textFieldColor,
                    labelText: MyStrings.password.tr,
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    nextFocus: controller.confirmPasswordFocusNode,
                    textInputType: TextInputType.text,
                    onChanged: (value) {
                      if (controller.checkPasswordStrength) {
                        controller.updateValidationList(value);
                      }
                    },
                    validator: (value) {
                      return controller.validatePassword(value ?? '');
                    },
                  )),
              const SizedBox(height: Dimensions.textToTextSpace),
              Visibility(
                  visible: controller.hasPasswordFocus &&
                      controller.checkPasswordStrength,
                  child: ValidationWidget(
                    list: controller.passwordValidationRules,
                  )),
              const SizedBox(height: Dimensions.space20),
              // const SizedBox(height: Dimensions.space20),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                labelText: MyStrings.confirmPassword.tr,
                leadingIcon: MyImages.passwordSvg,
                controller: controller.cPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                inputAction: TextInputAction.done,
                isShowSuffixIcon: true,
                isPassword: true,
                onChanged: (value) {},
                validator: (value) {
                  if (controller.passwordController.text.toLowerCase() !=
                      controller.cPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: Dimensions.space25),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.privacyScreen);
                            },
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "${MyStrings.agreementPolicy.tr} ",
                                      style: regularDefault.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: "Tajawal",
                                      )),
                                  TextSpan(
                                      text: MyStrings.privacyPolicy.tr,
                                      style: regularDefault.copyWith(
                                          color: MyColor.primaryColor)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space3),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: Dimensions.space30),

              GradientRoundedButton(
                  showLoadingIcon: controller.submitLoading,
                  text: MyStrings.signUp.tr,
                  press: () {
                    if (formKey.currentState!.validate() &&
                        controller.submitLoading == false) {
                      controller.signUpUser();
                    }
                  }),
            ],
          ),
        );
      },
    );
  }
}
