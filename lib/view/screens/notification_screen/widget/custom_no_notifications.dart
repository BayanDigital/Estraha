import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';

class CustomNoNotificationsWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomNoNotificationsWidget(
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
              MyImages.noNotificationsImage,
              width: size.height * .33,
              height: size.height * .33,
            ),
            const SizedBox(height: 40),
            Text(title.tr,
                style: tajawal20White700.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 20),
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text(subtitle.tr, style: semiBoldLarge),
            // SizedBox(height: context.height* .2,)
          ],
        ),
      ),
    );
  }
}
