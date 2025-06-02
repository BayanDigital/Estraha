import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/home/home_screen.dart';
import 'package:booking_box/view/screens/bottom_nav_sections/menu/menu_screen.dart';
import '../../screens/bottom_nav_sections/my_booking/my_booking_screen.dart';
import 'nav_bar_item_widget.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [
    const HomeScreen(),
    const MyBookingScreen(),
    const MenuScreen()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBody: true,
        body: screens[currentIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.ltr,
              children: [
                NavBarItem(
                  label: MyStrings.home,
                  imagePath: MyImages.homeSvg,
                  index: 0,
                  isSelected: currentIndex == 0,
                  press: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                ),
                NavBarItem(
                  label: MyStrings.booking.tr,
                  imagePath: MyImages.bottomNavBooking,
                  index: 1,
                  isSelected: currentIndex == 1,
                  press: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
                NavBarItem(
                  label: MyStrings.menu,
                  imagePath: MyImages.category,
                  index: 2,
                  isSelected: currentIndex == 2,
                  press: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
