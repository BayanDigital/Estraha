import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';

class OnboardController extends GetxController {
  int currentIndex = 0;
  PageController? controller = PageController();

  void setCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  List<String> onboardTitleList = [
    MyStrings.onboardTitle1,
    MyStrings.onboardTitle2,
    MyStrings.onboardTitle3,
  ];

  List<String> onboardSubTitleList = [
    MyStrings.onBoardSubTitle1,
    MyStrings.onBoardSubTitle2,
    MyStrings.onBoardSubTitle3,
  ];

  List<String> onboardImageList = [
    MyImages.onboardImage1,
    MyImages.onboardImage2,
    MyImages.onboardImage3,
  ];
}
