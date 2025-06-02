import 'package:booking_box/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestData extends StatelessWidget {
  const GuestData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Sign in to Show Hotels and Popular Cities".tr,
      style: tajawal14White400.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 15),
    ));
  }
}
