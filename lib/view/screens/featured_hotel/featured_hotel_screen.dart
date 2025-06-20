import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/featured_hotel/featured_hotel_controller.dart';
import 'package:booking_box/data/repo/featured_hotel/featured_hotel_repo.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/custom_loader/image_loader.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/style.dart';
import '../../../data/services/api_service.dart';
import '../../components/custom_loader/custom_loader.dart';

class FeaturedHotelScreen extends StatefulWidget {
  const FeaturedHotelScreen({super.key});

  @override
  State<FeaturedHotelScreen> createState() => _FeaturedHotelScreenState();
}

class _FeaturedHotelScreenState extends State<FeaturedHotelScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<FeaturedHotelController>().fetchFeaturedHotelData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<FeaturedHotelController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FeaturedHotelRepo(apiClient: Get.find()));
    final controller =
        Get.put(FeaturedHotelController(featuredHotelRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();

      scrollController.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<FeaturedHotelController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: CustomAppBar(
            title: MyStrings.featuredHotel.tr,
            bgColor: MyColor.appBarColor2,
            statusBarColor: MyColor.colorWhite,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : SafeArea(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.featuredHotelList.length + 1,
                    shrinkWrap: true,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (controller.featuredHotelList.length == index) {
                        return controller.hasNext()
                            ? SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                  child: CustomLoader(isPagination: true),
                                ),
                              )
                            : const SizedBox();
                      }

                      var hotelList =
                          controller.featuredHotelList[index].hotelSetting;

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.hotelDetailsScreen,
                              arguments: hotelList?.ownerId.toString() ?? '-1');
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                              color: MyColor.colorWhite,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      height: size.height * .22,
                                      width: size.width,
                                      fit: BoxFit.cover,
                                      imageUrl: hotelList?.imageUrl ??
                                          MyImages.defaultImageNetwork,
                                      placeholder: (context, url) =>
                                          const CustomImageLoader(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.space16),
                              Text(hotelList?.name?.tr ?? '',
                                  style: semiBoldLarge),
                              const SizedBox(height: Dimensions.space8),
                              Row(
                                children: [
                                  SvgPicture.asset(MyImages.location,
                                      colorFilter: const ColorFilter.mode(
                                          MyColor.bodyTextColor,
                                          BlendMode.srcIn)),
                                  const SizedBox(width: Dimensions.space8),
                                  Expanded(
                                      child: Text(
                                    hotelList?.hotelAddress?.tr ?? '',
                                    style: regularDefault.copyWith(
                                        color: MyColor.primaryTextColor),
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
