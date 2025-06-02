import 'package:booking_box/view/screens/auth/profile_complete/widget/country_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../data/controller/account/profile_complete_controller.dart';
import '../../../../data/repo/account/profile_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/app-bar/custom_appbar.dart';
import '../../../components/buttons/gradient_rounded_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/text-form-field/custom_text_field.dart';
import '../../../components/text-form-field/label_text_field.dart';
import '../../../components/warning_aleart_dialog.dart';
import '../registration/widget/my_image_widget.dart';

class ProfileCompleteScreen extends StatefulWidget {
  final bool signInWithGoogle;

  const ProfileCompleteScreen({Key? key, this.signInWithGoogle = false})
      : super(
          key: key,
        );

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    var controller =
        Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  bool isNumberBlank = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        const WarningAlertDialog().warningAlertDialog(context, () {
          Get.offAllNamed(RouteHelper.loginScreen);
        },
            titleMessage: MyStrings.areYourSure,
            subtitleMessage: MyStrings.youWantToDismiss);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: MyStrings.profileComplete.tr,
          isShowBackBtn: true,
          enableCustomBackPress: true,
          onBackPress: () => Get.offAllNamed(RouteHelper.loginScreen),
          fromAuth: false,
          isProfileCompleted: true,
          bgColor: MyColor.primaryColor,
          iconColor: MyColor.colorWhite,
          titleColor: MyColor.colorWhite,
        ),
        body: GetBuilder<ProfileCompleteController>(
          builder: (controller) {
            return SafeArea(
              child: controller.isLoading
                  ? const CustomLoader()
                  : SingleChildScrollView(
                      padding: Dimensions.screenPaddingHV,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.space15),
                            Text(
                              MyStrings.pleaseCompleteYourProfile.tr,
                              style: regularLargeTajawal.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              controller: controller.usernameController,
                              fillColor: MyColor.textFieldColor,
                              leadingIcon: MyImages.userSvg,
                              labelText: MyStrings.username.tr,
                              hintText: MyStrings.username.tr,
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.usernameFocusNode,
                              nextFocus: controller.addressFocusNode,
                              onChanged: (value) {
                                return;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return MyStrings.enterYourUsername.tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: Dimensions.space25),
                            LabelTextField(
                              hideLabel: true,
                              onChanged: (v) {},
                              labelText:
                                  (MyStrings.phoneNo).replaceAll('.', '').tr,
                              hintText: MyStrings.enterYourPhoneNumber,
                              controller: controller.mobileNoController,
                              focusNode: controller.mobileNoFocusNode,
                              textInputType: TextInputType.phone,
                              inputAction: TextInputAction.next,
                              prefixIcon: SizedBox(
                                width: 100,
                                child: FittedBox(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          CountryBottomSheet
                                              .profileCompleteCountryBottomSheet(
                                                  context, controller);
                                        },
                                        child: Container(
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(
                                              horizontal: Dimensions.space12),
                                          decoration: BoxDecoration(
                                            color:
                                                MyColor.getTransparentColor(),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              MyImageWidget(
                                                imageUrl: UrlContainer
                                                    .countryFlagImageLink
                                                    .replaceAll(
                                                        '{countryCode}',
                                                        controller.countryCode
                                                            .toString()
                                                            .toLowerCase()),
                                                height: Dimensions.space25,
                                                width: Dimensions.space40 + 2,
                                              ),
                                              const SizedBox(
                                                  width: Dimensions.space5),
                                              Text(
                                                "+${controller.mobileCode?.tr ?? ''}",
                                                style: regularLarge,
                                              ),
                                              const SizedBox(
                                                  width: Dimensions.space3),
                                              Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: MyColor.getIconColor(),
                                              ),
                                              Container(
                                                width: 2,
                                                height: Dimensions.space12,
                                                color: MyColor.borderColor,
                                              ),
                                              const SizedBox(
                                                  width: Dimensions.space8)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.address,
                              fillColor: MyColor.textFieldColor,
                              leadingIcon: MyImages.addressSvg,
                              hintText:
                                  "${MyStrings.enterYour.tr} ${MyStrings.address.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.addressFocusNode,
                              controller: controller.addressController,
                              nextFocus: controller.stateFocusNode,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.state,
                              fillColor: MyColor.textFieldColor,
                              leadingIcon: MyImages.stateSvg,
                              hintText:
                                  "${MyStrings.enterYour.tr} ${MyStrings.state.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.stateFocusNode,
                              controller: controller.stateController,
                              nextFocus: controller.cityFocusNode,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.city.tr,
                              fillColor: MyColor.textFieldColor,
                              leadingIcon: MyImages.citySvg,
                              hintText:
                                  "${MyStrings.enterYour.tr} ${MyStrings.city.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.cityFocusNode,
                              controller: controller.cityController,
                              nextFocus: controller.zipCodeFocusNode,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space25),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.zipCode.tr,
                              fillColor: MyColor.textFieldColor,
                              leadingIcon: MyImages.zipCode,
                              hintText:
                                  "${MyStrings.enterYour.tr} ${MyStrings.zipCode.toLowerCase().tr}",
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.done,
                              focusNode: controller.zipCodeFocusNode,
                              controller: controller.zipCodeController,
                              onChanged: (value) {
                                return;
                              },
                            ),
                            const SizedBox(height: Dimensions.space35),
                            GradientRoundedButton(
                              showLoadingIcon: controller.submitLoading,
                              text: MyStrings.completeProfile.tr,
                              press: () {
                                if (formKey.currentState!.validate() &&
                                    controller.submitLoading == false) {
                                  controller.updateProfile();
                                }
                                // controller.updateProfile();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
