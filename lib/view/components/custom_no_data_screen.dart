import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';

class CustomNoDataScreen extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomNoDataScreen(
      {Key? key, this.title = MyStrings.noDataFound, this.subtitle = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo/splash_logo.png",
              height: 138,
              width: 118,
              // fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              title.tr,
              style: tajawal15PrimaryColor500.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              subtitle.tr,
              style: tajawal15PrimaryColor500.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
            // SizedBox(height: context.height* .2,)
          ],
        ),
      ),
    );
  }
}
