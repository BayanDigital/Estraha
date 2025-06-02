import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';

class CustomNoPreviousHistory extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomNoPreviousHistory(
      {Key? key, this.title = MyStrings.noDataFound, this.subtitle = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                MyImages.noPrevioustHistoryImage,
                width: 252,
                height: 252,
              ),
            ),
            const SizedBox(height: 20),
            Text(title.tr,
                style: tajawal20White700.copyWith(
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text(
                textAlign: TextAlign.center,
                subtitle.tr,
                style: tajawal14White400.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor)),
            // SizedBox(height: context.height* .2,)
          ],
        ),
      ),
    );
  }
}
