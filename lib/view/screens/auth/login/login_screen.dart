import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/auth/login_controller.dart';
import 'package:booking_box/data/repo/auth/login_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/text-form-field/custom_text_field.dart';
import 'package:booking_box/view/components/text/default_text.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/shared_preference_helper.dart';
import '../../../../core/utils/util.dart';
import '../../../../data/controller/auth/social_login_controller.dart';
import '../../../../data/repo/auth/social_login_repo.dart';
import '../../../components/buttons/gradient_rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));
    Get.put(SocialLoginRepo(apiClient: Get.find()));
    Get.put(SocialLoginController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: MyColor.transparentColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: MyColor.colorWhite,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: WillPopWidget(
        nextRoute: '',
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: GetBuilder<LoginController>(
            builder: (controller) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * .05),
                  Stack(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            MyImages.splashLogo,
                            height: 193,
                            width: 165,
                            fit: BoxFit.cover,
                          )),
                      Visibility(
                        visible: Get.find<ApiClient>()
                                .getGSData()
                                .data
                                ?.generalSetting
                                ?.multiLanguage ==
                            1,
                        child: Positioned(
                          top: 45,
                          right: MyUtils.isRtl(context) ? null : 12,
                          left: MyUtils.isRtl(context) ? 12 : null,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.languageScreen);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.space10,
                                  vertical: Dimensions.space7),
                              decoration: BoxDecoration(
                                  color: MyColor.primaryColor.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: .5, color: MyColor.naturalDark)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    MyImages.language,
                                    width: 16,
                                    height: 16,
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context).primaryColor,
                                        BlendMode.srcIn),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.space4,
                                  ),
                                  Text(Get.find<ApiClient>()
                                          .sharedPreferences
                                          .getString(SharedPreferenceHelper
                                              .languageCode)
                                          ?.toUpperCase() ??
                                      'EN'.toUpperCase().tr)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: Dimensions.defaultPaddingHV,
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          MyStrings.welcomeBack.tr,
                          style: tajawal20White700.copyWith(
                              fontSize: 24,
                              color: Theme.of(context).primaryColor),
                        )),
                        SizedBox(height: size.height * .04),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextField(
                                animatedLabel: true,
                                needOutlineBorder: true,
                                leadingIcon: MyImages.emailSvg,
                                fillColor: MyColor.textFieldColor,
                                controller: controller.emailController,
                                labelText: MyStrings.emailOrUsername.tr,
                                onChanged: (value) {},
                                focusNode: controller.emailFocusNode,
                                nextFocus: controller.passwordFocusNode,
                                textInputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.next,
                                borderRadius: Dimensions.inputFieldBorderRadius,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return MyStrings
                                        .enterYourEmailOrUsername.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: Dimensions.space20),
                              CustomTextField(
                                animatedLabel: true,
                                needOutlineBorder: true,
                                leadingIcon: MyImages.passwordSvg,
                                fillColor: MyColor.textFieldColor,
                                labelText: MyStrings.password.tr,
                                controller: controller.passwordController,
                                focusNode: controller.passwordFocusNode,
                                onChanged: (value) {},
                                isShowSuffixIcon: true,
                                isPassword: true,
                                borderRadius: Dimensions.inputFieldBorderRadius,
                                textInputType: TextInputType.text,
                                inputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return MyStrings.enterYourPassword.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .defaultRadius)),
                                            activeColor: MyColor.primaryColor,
                                            checkColor: MyColor.colorWhite,
                                            value: controller.remember,
                                            side: WidgetStateBorderSide
                                                .resolveWith(
                                              (states) => BorderSide(
                                                  width: 1.0,
                                                  color: controller.remember
                                                      ? MyColor
                                                          .getTextFieldEnableBorder()
                                                      : MyColor
                                                          .getTextFieldDisableBorder()),
                                            ),
                                            onChanged: (value) {
                                              controller.changeRememberMe();
                                            }),
                                      ),
                                      const SizedBox(width: 8),
                                      DefaultText(
                                          text: MyStrings.rememberMe.tr,
                                          textColor: MyColor.thinTextColor)
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.clearTextField();
                                      Get.toNamed(
                                          RouteHelper.forgotPasswordScreen);
                                    },
                                    child: DefaultText(
                                      text: MyStrings.forgotPassword.tr,
                                      textColor: MyColor.primaryColor,
                                      textStyle: const TextStyle(
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 25),
                              GradientRoundedButton(
                                  showLoadingIcon: controller.isSubmitLoading,
                                  text: MyStrings.signIn.tr,
                                  press: () {
                                    if (formKey.currentState!.validate() &&
                                        controller.isSubmitLoading == false) {
                                      controller.loginUser();
                                    }
                                  }),
                              const SizedBox(height: Dimensions.space20),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouteHelper.guestHomeScreen,
                                        (route) => false);
                                  },
                                  child: Text("Sign In as Guest".tr,
                                      style: regularDefault.copyWith(
                                          color: MyColor.primaryColor,
                                          fontFamily: "Tajawal",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600))),
                              // const SocialLoginSection(),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .09),

                              SafeArea(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(MyStrings.doNotHaveAccount.tr,
                                        overflow: TextOverflow.ellipsis,
                                        style: regularLargeTajawal.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(width: Dimensions.space5),
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            RouteHelper.registrationScreen);
                                      },
                                      child: Text(MyStrings.signUp.tr,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: regularLargeTajawal.copyWith(
                                              color: MyColor.getPrimaryColor(),
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
