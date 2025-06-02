import 'package:booking_box/data/controller/review_booking/review_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/core/utils/url_container.dart';
import 'package:booking_box/core/utils/util.dart';
import 'package:booking_box/data/controller/account/profile_complete_controller.dart';
import 'package:booking_box/view/components/card/bottom_sheet_card.dart';
import 'package:get/get.dart';
import '../../../../../data/model/country_model/country_model.dart';
import '../../../../components/bottom-sheet/bottom_sheet_bar.dart';
import '../../../../components/bottom-sheet/custom_bottom_sheet_plus.dart';
import '../../../../components/text-form-field/label_text_field.dart';
import '../../registration/widget/my_image_widget.dart';

class CountryBottomSheet {
  static void profileCompleteCountryBottomSheet(
      BuildContext context, ProfileCompleteController controller) {
    CustomBottomSheetPlus(
        bgColor: MyColor.screenBgColor,
        isNeedPadding: false,
        child: StatefulBuilder(builder: (context, setState) {
          if (controller.filteredCountries.isEmpty) {
            controller.filteredCountries = controller.countryList;
          }
          // Function to filter countries based on the search input.
          void filterCountries(String query) {
            if (query.isEmpty) {
              controller.filteredCountries = controller.countryList;
            } else {
              List<Countries> filterData = controller.filteredCountries
                  .where((country) => country.country!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();
              setState(() {
                controller.filteredCountries = filterData;
              });
            }
          }

          return Container(
            height: MediaQuery.of(context).size.height * .9,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: MyColor.screenBgColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: MyUtils.getShadow(),
            ),
            child: Column(
              children: [
                const BottomSheetBar(),
                const SizedBox(height: 10),
                LabelTextField(
                  labelText: '',
                  hintText: MyStrings.searchCountry.tr,
                  controller: controller.countryController,
                  textInputType: TextInputType.text,
                  onChanged: filterCountries,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: MyColor.naturalLight,
                  ),
                  labelTextStyle: boldDefault.copyWith(),
                  fillColor: MyColor.textFieldColor,
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: ListView.builder(
                      itemCount: controller.filteredCountries.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var countryItem = controller.filteredCountries[index];

                        return GestureDetector(
                          onTap: () {
                            controller.countryController.text =
                                controller.filteredCountries[index].country ??
                                    '';
                            controller.setCountryNameAndCode(
                                controller.filteredCountries[index].country ??
                                    '',
                                controller
                                        .filteredCountries[index].countryCode ??
                                    '',
                                controller.filteredCountries[index].dialCode ??
                                    '');

                            Navigator.pop(context);

                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: BottomSheetCard(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: Dimensions.space10),
                                  child: MyImageWidget(
                                    imageUrl: UrlContainer.countryFlagImageLink
                                        .replaceAll(
                                            "{countryCode}",
                                            countryItem.countryCode
                                                .toString()
                                                .toLowerCase()),
                                    height: Dimensions.space25,
                                    width: Dimensions.space40 + 2,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '+${controller.filteredCountries[index].dialCode?.tr}  ${controller.filteredCountries[index].country?.tr ?? ''}',
                                    style: regularDefault.copyWith(
                                        color: MyColor.getTextColor()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        })).show(context);
  }

  static void reviewBookingCountryBottomSheet(
      BuildContext context, ReviewBookingController controller) {
    CustomBottomSheetPlus(
        bgColor: MyColor.screenBgColor,
        isNeedPadding: false,
        child: StatefulBuilder(builder: (context, setState) {
          if (controller.filteredCountries.isEmpty) {
            controller.filteredCountries = controller.countryList;
          }
          // Function to filter countries based on the search input.
          void filterCountries(String query) {
            if (query.isEmpty) {
              controller.filteredCountries = controller.countryList;
            } else {
              List<Countries> filterData = controller.filteredCountries
                  .where((country) => country.country!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();
              setState(() {
                controller.filteredCountries = filterData;
              });
            }
          }

          return Container(
            height: MediaQuery.of(context).size.height * .9,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: MyColor.screenBgColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: MyUtils.getShadow(),
            ),
            child: Column(
              children: [
                const BottomSheetBar(),
                const SizedBox(height: 10),
                LabelTextField(
                  labelText: '',
                  hintText: MyStrings.searchCountry.tr,
                  controller: controller.countryController,
                  textInputType: TextInputType.text,
                  onChanged: filterCountries,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: MyColor.naturalLight,
                  ),
                  labelTextStyle: boldDefault.copyWith(),
                  fillColor: MyColor.textFieldColor,
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: ListView.builder(
                      itemCount: controller.filteredCountries.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var countryItem = controller.filteredCountries[index];

                        return GestureDetector(
                          onTap: () {
                            controller.countryController.text =
                                controller.filteredCountries[index].country ??
                                    '';
                            controller.setCountryNameAndCode(
                                controller.filteredCountries[index].country ??
                                    '',
                                controller
                                        .filteredCountries[index].countryCode ??
                                    '',
                                controller.filteredCountries[index].dialCode ??
                                    '');

                            Navigator.pop(context);

                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: BottomSheetCard(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: Dimensions.space10),
                                  child: MyImageWidget(
                                    imageUrl: UrlContainer.countryFlagImageLink
                                        .replaceAll(
                                            "{countryCode}",
                                            countryItem.countryCode
                                                .toString()
                                                .toLowerCase()),
                                    height: Dimensions.space25,
                                    width: Dimensions.space40 + 2,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '+${controller.filteredCountries[index].dialCode?.tr}  ${controller.filteredCountries[index].country?.tr ?? ''}',
                                    style: regularDefault.copyWith(
                                        color: MyColor.getTextColor()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        })).show(context);
  }
}
