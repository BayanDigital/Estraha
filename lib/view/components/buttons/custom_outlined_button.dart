import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';

class CustomOutlinedBtn extends StatelessWidget {
  final String btnText;
  final void Function() onTap;
  final double radius;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final double width;
  final double height;
  final double borderWidth;
  final Widget? icon;
  final TextStyle? textStyle;
  final bool isLoading;

  const CustomOutlinedBtn({
    super.key,
    required this.btnText,
    required this.onTap,
    this.radius = Dimensions.defaultRadius,
    this.bgColor = MyColor.transparentColor,
    this.borderColor = MyColor.borderColor,
    this.textColor = MyColor.colorBlack,
    this.width = double.infinity,
    this.height = Dimensions.defaultButtonH,
    this.icon,
    this.textStyle,
    this.isLoading = false,
    this.borderWidth = .5,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? GestureDetector(
            onTap: () {
              if (isLoading == false) {
                onTap();
              }
            },
            child: Card(
              color: MyColor.colorWhite,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? const SizedBox.shrink()
                        : icon ?? const SizedBox.shrink(),
                    const SizedBox(
                      width: Dimensions.space16,
                    ),
                    isLoading
                        ? SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                                color: MyColor.getPrimaryColor()),
                          )
                        : Text(
                            btnText.tr, //
                            style: textStyle ??
                                semiBoldOverLargeManrope.copyWith(fontSize: 14),
                          ),
                  ],
                ),
              ),
            ),
          )

        /*? OutlinedButton.icon(
            onPressed: () {
              if (isLoading == false) {
                onTap();
              }
            },
            style: OutlinedButton.styleFrom(
              elevation: 0, //
              backgroundColor: bgColor,
              surfaceTintColor: MyColor.getPrimaryColor().withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
              maximumSize: Size.fromHeight(height),
              minimumSize: Size(width, height),
              side: BorderSide(color: borderColor, width: borderWidth),
              splashFactory: InkRipple.splashFactory,
            ),
            icon: isLoading ? const SizedBox.shrink() : icon ?? const SizedBox.shrink(),
            label: isLoading
                ?  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: MyColor.getPrimaryColor()),
                  )
                : Text(
                    btnText, //
                    style: textStyle ?? boldDefault.copyWith(color: textColor),
                  ),
          )*/
        : OutlinedButton(
            onPressed: () {
              if (isLoading == false) {
                onTap();
              }
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: bgColor,
              elevation: 0, //
              surfaceTintColor: MyColor.getPrimaryColor().withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius)),
              maximumSize: Size.fromHeight(height),
              minimumSize: Size(width, height),
              side: BorderSide(color: borderColor, width: borderWidth),
              splashFactory: InkRipple.splashFactory,
            ),
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        color: MyColor.getPrimaryColor()),
                  )
                : Text(
                    btnText.tr, //
                    style: textStyle ??
                        boldDefault.copyWith(
                          color: textColor,
                        ),
                  ),
          );
  }
}
