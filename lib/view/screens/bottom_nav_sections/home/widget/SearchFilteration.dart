// // ignore_for_file: deprecated_member_use

// import 'package:booking_box/data/controller/filter/filter_controller.dart'
//     show FilterController;
// import 'package:booking_box/data/controller/search_result/search_result_controller.dart';
// import 'package:booking_box/data/repo/filter_pram/filter_pram_repo.dart';
// import 'package:booking_box/data/repo/search_result/search_repo.dart';
// import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';
// import 'package:booking_box/view/screens/bottom_nav_sections/home/widget/home_custom_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:booking_box/core/route/route.dart';
// import 'package:booking_box/core/utils/dimensions.dart';
// import 'package:booking_box/core/utils/my_color.dart';
// import 'package:booking_box/core/utils/my_strings.dart';
// import 'package:booking_box/core/utils/util.dart';
// import 'package:booking_box/data/controller/home/home_controller.dart';
// import 'package:booking_box/data/repo/home/home_repo.dart';
// import 'package:booking_box/data/services/api_service.dart';
// import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';
// import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
// import 'package:booking_box/view/components/will_pop_widget.dart';
// import 'package:booking_box/view/screens/bottom_nav_sections/home/widget/featuren_hotel_section.dart';
// import 'package:booking_box/view/screens/bottom_nav_sections/home/widget/filter_search_section.dart';
// import 'package:booking_box/view/screens/bottom_nav_sections/home/widget/popular_city_section.dart';
// import 'package:booking_box/view/screens/bottom_nav_sections/home/widget/popular_hotel_section.dart';

// class SearchFilteration extends StatefulWidget {
//   const SearchFilteration({Key? key, required HomeController controller})
//       : super(key: key);

//   @override
//   State<SearchFilteration> createState() => _SearchFilterationState();
// }

// class _SearchFilterationState extends State<SearchFilteration> {
//   @override
//   void initState() {
//     MyUtils.allScreen();
//     Get.put(ApiClient(sharedPreferences: Get.find()));
//     Get.put(HomeRepo(apiClient: Get.find()));
//     final controller =
//         Get.put(HomeController(homeRepo: Get.find()), permanent: true);
//     Get.put(SearchRepo(apiClient: Get.find()));
//     Get.put(FilterPramRepo(apiClient: Get.find()));
//     Get.put(FilterController(filterPramRepo: Get.find()));
//     Get.put(SearchResultController(searchRepo: Get.find()));

//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       controller.loadData();
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GetBuilder<HomeController>(builder: (controller) {
//       return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: const SystemUiOverlayStyle(
//             statusBarColor: MyColor.primaryColor,
//             statusBarBrightness: Brightness.dark,
//             statusBarIconBrightness: Brightness.light),
//         child: WillPopWidget(
//           nextRoute: "",
//           child: Scaffold(
//             extendBody: true,
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             body: controller.isLoading
//                 ? const CustomLoader()
//                 : SafeArea(
//                     child: Column(
//                       children: [
//                         const HomeCustomAppbar(),
//                         Expanded(
//                           child: RefreshIndicator(
//                             color: MyColor.primaryColor,
//                             onRefresh: () async {
//                               controller.loadData(isPullRefresh: true);
//                             },
//                             child: SingleChildScrollView(
//                               physics: const BouncingScrollPhysics(),
//                               child: Stack(
//                                 children: [
//                                   FilterSearchSection(controller: controller),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 310),
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 16),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         controller.adsList.isEmpty
//                                             ? const SizedBox.shrink()
//                                             : Column(
//                                                 children: [
//                                                   const SizedBox(
//                                                       height:
//                                                           Dimensions.space12),
//                                                   SingleChildScrollView(
//                                                     scrollDirection:
//                                                         Axis.horizontal,
//                                                     child: Row(
//                                                       children: List.generate(
//                                                           controller
//                                                               .adsList.length,
//                                                           (index) =>
//                                                               GestureDetector(
//                                                                 onTap: () {
//                                                                   int? ownerId =
//                                                                       int.tryParse(controller
//                                                                               .adsList[index]
//                                                                               .ownerId ??
//                                                                           '-1');
//                                                                   if (ownerId! >
//                                                                       0) {
//                                                                     if (controller.checkOutDate ==
//                                                                             MyStrings
//                                                                                 .checkOutDate ||
//                                                                         controller.checkOutDate ==
//                                                                             MyStrings.startDate) {
//                                                                       CustomSnackBar
//                                                                           .error(
//                                                                               errorList: [
//                                                                             MyStrings.selectCheckOut.tr
//                                                                           ]);
//                                                                     } else {
//                                                                       Get.toNamed(
//                                                                           RouteHelper
//                                                                               .hotelDetailsScreen,
//                                                                           arguments: controller
//                                                                               .adsList[index]
//                                                                               .ownerId);
//                                                                     }
//                                                                   } else if (controller
//                                                                               .adsList[
//                                                                                   index]
//                                                                               .url !=
//                                                                           null &&
//                                                                       controller
//                                                                           .adsList[
//                                                                               index]
//                                                                           .url!
//                                                                           .isNotEmpty) {
//                                                                     controller.addLaunchUrl(
//                                                                         controller.adsList[index].url ??
//                                                                             '');
//                                                                   }
//                                                                 },
//                                                                 child: Padding(
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                           .only(
//                                                                           right:
//                                                                               16),
//                                                                   child: ClipRRect(
//                                                                       borderRadius:
//                                                                           BorderRadius.circular(
//                                                                               8),
//                                                                       child: CustomCashNetworkImage(
//                                                                           imageHeight: size.height *
//                                                                               .16,
//                                                                           imageWidth: size.width *
//                                                                               .7,
//                                                                           imageUrl: controller
//                                                                               .adsList[index]
//                                                                               .imageUrl
//                                                                               .toString())),
//                                                                 ),
//                                                               )),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                       height:
//                                                           Dimensions.space12),
//                                                 ],
//                                               ),
//                                         controller.popularHotelList.isEmpty
//                                             ? const SizedBox.shrink()
//                                             : PopularHotelSection(
//                                                 controller: controller),
//                                         controller.popularCityList.isEmpty
//                                             ? const SizedBox.shrink()
//                                             : const PopularCitySection(),
//                                         FeaturedHotelSection(
//                                             controller: controller),
//                                         SizedBox(height: size.height * .02)
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//         ),
//       );
//     });
//   }
// }
