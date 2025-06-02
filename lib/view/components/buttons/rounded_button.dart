import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';

class RoundedButton extends StatelessWidget {
  final bool isColorChange;
  final String text;
  final VoidCallback press;
  final Color color;
  final Color? textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  final bool isOutlined;
  final Color borderColor;
  final Widget? child;

  const RoundedButton({
    Key? key,
    this.isColorChange = false,
    this.width = 1,
    this.child,
    this.cornerRadius = 6,
    required this.text,
    required this.press,
    this.isOutlined = false,
    this.horizontalPadding = 35,
    this.verticalPadding = 18,
    this.color = MyColor.primaryColor,
    this.textColor = MyColor.colorWhite,
    this.borderColor = MyColor.transparentColor,
    int height = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return child != null
        ? InkWell(
            onTap: press,
            splashColor: MyColor.getScreenBgColor(),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              width: size.width * width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    cornerRadius), // استخدم cornerRadius هنا
                color: isColorChange ? color : MyColor.getPrimaryButtonColor(),
              ),
              child: Center(
                child: Text(
                  text.tr,
                  style: TextStyle(
                    color: isColorChange
                        ? textColor
                        : MyColor.getPrimaryButtonTextColor(),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Tajawal",
                  ),
                ),
              ),
            ),
          )
        : isOutlined
            ? Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: press,
                  splashColor: MyColor.getScreenBgColor(),
                  borderRadius: BorderRadius.circular(
                      cornerRadius), // مهم للـ splash يكون نفس الراديوس
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding),
                    width: size.width * width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cornerRadius),
                      color: isColorChange
                          ? color
                          : Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                        color: borderColor,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        text.tr,
                        style: TextStyle(
                          color: isColorChange
                              ? textColor
                              : MyColor.getPrimaryButtonTextColor(),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Tajawal",
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: size.width * width,
                child: ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shadowColor: MyColor.transparentColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(cornerRadius),
                    ),
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  child: Text(
                    text.tr,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Tajawal",
                    ),
                  ),
                ),
              );
  }
}
