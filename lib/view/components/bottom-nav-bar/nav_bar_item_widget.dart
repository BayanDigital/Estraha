// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';

class NavBarItem extends StatelessWidget {
  final String imagePath;
  final int index;
  final String label;
  final VoidCallback press;
  final bool isSelected;

  const NavBarItem({
    Key? key,
    required this.imagePath,
    required this.index,
    required this.label,
    required this.isSelected,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        // width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? MyColor.primaryColor.withOpacity(0.5)
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              label.tr,
              style: tajawal14White400.copyWith(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            imagePath.contains('svg')
                ? SvgPicture.asset(
                    imagePath,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    ),
                    width: 18,
                    height: 18,
                  )
                : Image.asset(
                    imagePath,
                    color:
                        isSelected ? MyColor.primaryColor : MyColor.iconColor,
                    width: 18,
                    height: 18,
                  ),
          ],
        ),
      ),
    );
  }
}
