import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/style.dart';

class LabelText extends StatelessWidget {

  final bool isRequired;
  final String text;
  final TextAlign? textAlign;
  final TextStyle? textStyle;

  const LabelText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isRequired?Row(
      children: [
        Text(
        text.tr,
        textAlign: textAlign,
        style:textStyle ?? regularDefault.copyWith(color: MyColor.getLabelTextColor())
        ),
        const SizedBox(width: 2,),
        Text('*',style: semiBoldDefault.copyWith(color: MyColor.colorRed),)
      ],
     ) :
    Text(
      text.tr,
      textAlign: textAlign,
      style: regularDefault.copyWith(color: MyColor.getLabelTextColor()),
    );
  }
}
