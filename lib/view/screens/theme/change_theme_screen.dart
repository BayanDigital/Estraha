import 'package:booking_box/core/helper/theme_helper.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangeThemeScreen extends StatelessWidget {
  const ChangeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Change Theme".tr,
        bgColor: MyColor.colorWhite,
        isShowBackBtn: true,
        isTitleCenter: true,
        isShowElevation: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Theme".tr,
                      style: GoogleFonts.tajawal(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.85,
                      child: CupertinoSwitch(
                        activeColor: MyColor.primaryColor,
                        inactiveThumbColor: MyColor.primaryColor,
                        value: Provider.of<ThemeProvider>(context).isDarkMode,
                        onChanged: (value) =>
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme(),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 40.h),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.primary,
              //     borderRadius: BorderRadius.circular(12.r),
              //   ),
              //   padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "language".tr(),
              //         style: GoogleFonts.patrickHand(fontSize: 26.sp),
              //       ),
              //       CupertinoSwitch(
              //         value: languageProvider.currentLanguage == 'ar',
              //         onChanged: (_) =>
              //             languageProvider.toggleLanguage(context),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
