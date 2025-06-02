import 'package:booking_box/core/utils/util.dart';
import 'package:booking_box/data/controller/filter/filter_controller.dart';
import 'package:booking_box/data/controller/search_result/search_result_controller.dart';
import 'package:booking_box/data/repo/filter_pram/filter_pram_repo.dart';
import 'package:booking_box/data/repo/home/home_repo.dart';
import 'package:booking_box/data/repo/search_result/search_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';

import '../../../../../core/route/route.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/home/home_controller.dart';
import '../../../../../data/model/home/home_model.dart';
import '../../../../components/snack_bar/show_custom_snackbar.dart';
import 'custom_header.dart';

class PopularCitySection extends StatefulWidget {
  const PopularCitySection({super.key});

  @override
  State<PopularCitySection> createState() => _PopularCitySectionState();
}

class _PopularCitySectionState extends State<PopularCitySection> {
  @override
  void initState() {
    MyUtils.allScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller = Get.put(
        HomeController(homeRepo: Get.find(), permanent: true),
        permanent: true);
    Get.put(SearchRepo(apiClient: Get.find()));
    Get.put(FilterPramRepo(apiClient: Get.find()));
    Get.put(FilterController(filterPramRepo: Get.find()));
    Get.put(SearchResultController(searchRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomHeader(
            title: MyStrings.popularCity,
            isShowSeeMoreButton: controller.popularCityList.length <
                controller.totalPopularCities,
            actionPress: () {
              Get.toNamed(RouteHelper.popularCityScreen);
            },
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 210,
              ),
              itemCount: controller.popularCityList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                PopularCity cityData = controller.popularCityList[index];

                return GestureDetector(
                  onTap: () {
                    if (controller.checkOutDate == MyStrings.checkOutDate ||
                        controller.checkOutDate == MyStrings.startDate) {
                      CustomSnackBar.error(
                          errorList: [MyStrings.selectCheckOut.tr]);
                    } else {
                      controller.manageSearchTextForDestinationClick(
                        cityData.name ?? '',
                        cityData.country?.name ?? '',
                        cityData.id.toString(),
                      );
                      Get.toNamed(RouteHelper.searchResultScreen,
                          arguments: true);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amberAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: CustomCashNetworkImage(
                            imageHeight: 130,
                            imageWidth: double.infinity,
                            imageUrl: cityData.imageUrl.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Text(
                                cityData.name?.tr ?? '',
                                style: boldLarge.copyWith(
                                  fontFamily: "Tajawal",
                                  color: Theme.of(context).primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${cityData.totalHotel.toString()} ${MyStrings.hotel}",
                                style: regularDefault.copyWith(
                                  fontFamily: "Tajawal",
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Color> getImageDominantColor(String imagePath) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(imagePath),
      size: const Size(200, 200),
    );

    return paletteGenerator.dominantColor?.color ?? MyColor.colorWhite;
  }
}
