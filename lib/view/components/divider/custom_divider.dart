import 'package:flutter/material.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';

class CustomDivider extends StatelessWidget {
  final double space;
  final Color color;
  final double thickness;

  const CustomDivider(
      {Key? key,
      this.space = Dimensions.space20,
      this.color = MyColor.transparentColor,
      this.thickness = 0.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Divider(
            // color: Theme.of(context).primaryColor,
            height: 0.5,
            thickness: thickness),
        const SizedBox(height: 5),
      ],
    );
  }
}
