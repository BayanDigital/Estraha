// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/view/components/text/label_text.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final bool needRequiredSign;
  final int maxLines;
  final bool animatedLabel;
  final Color fillColor;
  final bool isRequired;
  final String? leadingIcon;
  final double iconSize;
  final double borderRadius;
  final bool? isBordered;

  const CustomTextField(
      {Key? key,
      this.labelText,
      this.readOnly = false,
      this.fillColor = MyColor.textFieldColor,
      required this.onChanged,
      this.hintText,
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.validator,
      this.textInputType,
      this.isEnable = true,
      this.isPassword = false,
      this.isShowSuffixIcon = false,
      this.isIcon = false,
      this.onSuffixTap,
      this.borderRadius = Dimensions.defaultRadius,
      this.isSearch = false,
      this.isCountryPicker = false,
      this.inputAction = TextInputAction.next,
      this.needOutlineBorder = false,
      this.needRequiredSign = false,
      this.maxLines = 1,
      this.animatedLabel = false,
      this.isRequired = false,
      this.leadingIcon,
      this.iconSize = 20,
      this.isBordered = false})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.needOutlineBorder
        ? widget.animatedLabel
            ? Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent.withValues(alpha: 0.5),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  maxLines: widget.maxLines,
                  readOnly: widget.readOnly,
                  style: regularDefault.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "Tajawal"),
                  //textAlign: TextAlign.left,
                  cursorColor: Theme.of(context).scaffoldBackgroundColor,
                  controller: widget.controller,
                  autofocus: false,
                  textInputAction: widget.inputAction,
                  enabled: widget.isEnable,
                  focusNode: widget.focusNode,
                  validator: widget.validator,
                  keyboardType: widget.textInputType,
                  obscureText: widget.isPassword ? obscureText : false,
                  decoration: InputDecoration(
                    hintText: widget.labelText?.tr ?? '',
                    contentPadding: const EdgeInsets.only(
                        top: 5, left: 15, right: 15, bottom: 5),
                    labelStyle: regularLarge.copyWith(
                        color: MyColor.thinTextColor, fontFamily: "Tajawal"),
                    fillColor: Theme.of(context).cardColor,
                    filled: true,
                    // prefixIcon: widget.leadingIcon != null
                    //     ? widget.leadingIcon!.contains('.svg')
                    //         ? Padding(
                    //             padding: const EdgeInsets.only(
                    //                 top: 5, left: 15, right: 10, bottom: 5),
                    //             child: SvgPicture.asset(widget.leadingIcon!,
                    //                 width: widget.iconSize,
                    //                 height: widget.iconSize,
                    //                 colorFilter: const ColorFilter.mode(
                    //                     Color(0xffBDBDBD), BlendMode.srcIn)),
                    //           )
                    //     : Padding(
                    //         padding: const EdgeInsets.all(9.0),
                    //         child: Image.asset(
                    //           widget.leadingIcon!,
                    //           width: 2,
                    //           height: 2,
                    //           color: const Color(0xffBDBDBD),
                    //         ),
                    //       )
                    // : null,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0.5, color: MyColor.grayScale600),
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0.5, color: MyColor.grayScale600),
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0.5, color: MyColor.grayScale600),
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0.5, color: MyColor.colorRed),
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0.5, color: MyColor.colorRed),
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius)),
                    suffixIcon: widget.isShowSuffixIcon
                        ? widget.isPassword
                            ? IconButton(
                                icon: Icon(
                                    obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: MyColor.primaryColor,
                                    size: 20),
                                onPressed: _toggle)
                            : widget.isIcon
                                ? IconButton(
                                    onPressed: widget.onSuffixTap,
                                    icon: Icon(
                                      widget.isSearch
                                          ? Icons.search_outlined
                                          : widget.isCountryPicker
                                              ? Icons.arrow_drop_down_outlined
                                              : Icons.camera_alt_outlined,
                                      size: 25,
                                      color: MyColor.getPrimaryColor(),
                                    ),
                                  )
                                : null
                        : null,
                  ),
                  onFieldSubmitted: (text) => widget.nextFocus != null
                      ? FocusScope.of(context).requestFocus(widget.nextFocus)
                      : null,
                  onChanged: (text) => widget.onChanged!(text),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText(
                      text: widget.labelText.toString().tr,
                      isRequired: widget.isRequired),
                  const SizedBox(height: Dimensions.textToTextSpace),
                  TextFormField(
                    maxLines: widget.maxLines,
                    readOnly: widget.readOnly,
                    style:
                        regularDefault.copyWith(color: MyColor.getTextColor()),
                    //textAlign: TextAlign.left,
                    cursorColor: MyColor.getTextColor(),
                    controller: widget.controller,
                    autofocus: true,
                    textInputAction: widget.inputAction,
                    enabled: widget.isEnable,
                    focusNode: widget.focusNode,
                    validator: widget.validator,
                    keyboardType: widget.textInputType,
                    obscureText: widget.isPassword ? obscureText : false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 5, left: 15, right: 15, bottom: 5),
                      hintText:
                          widget.hintText != null ? widget.hintText!.tr : '',
                      hintStyle: regularSmall.copyWith(
                          color: MyColor.getHintTextColor().withOpacity(0.7)),
                      fillColor: MyColor.transparentColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5,
                              color: MyColor.getTextFieldDisableBorder()),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5,
                              color: MyColor.getTextFieldEnableBorder()),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5,
                              color: MyColor.getTextFieldDisableBorder()),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
                      suffixIcon: widget.isShowSuffixIcon
                          ? widget.isPassword
                              ? IconButton(
                                  icon: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: MyColor.hintTextColor,
                                      size: 20),
                                  onPressed: _toggle)
                              : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                                ? Icons.arrow_drop_down_outlined
                                                : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    )
                                  : null
                          : null,
                    ),
                    onFieldSubmitted: (text) => widget.nextFocus != null
                        ? FocusScope.of(context).requestFocus(widget.nextFocus)
                        : null,
                    onChanged: (text) => widget.onChanged!(text),
                  )
                ],
              )
        : TextFormField(
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            style: regularDefault.copyWith(color: MyColor.getTextColor()),
            //textAlign: TextAlign.left,
            cursorColor: MyColor.getHintTextColor(),
            controller: widget.controller,
            autofocus: false,
            textInputAction: widget.inputAction,
            enabled: widget.isEnable,
            focusNode: widget.focusNode,
            validator: widget.validator,
            keyboardType: widget.textInputType,
            obscureText: widget.isPassword ? obscureText : false,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
              labelText: widget.labelText?.tr,
              labelStyle: regularDefault.copyWith(
                  color: widget.isSearch
                      ? MyColor.bodyTextColor
                      : MyColor.getLabelTextColor()),
              fillColor: MyColor.transparentColor,
              filled: true,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.5, color: MyColor.getTextFieldDisableBorder())),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.5, color: MyColor.getTextFieldEnableBorder())),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.5, color: MyColor.getTextFieldDisableBorder())),
              suffixIcon: widget.isShowSuffixIcon
                  ? widget.isPassword
                      ? IconButton(
                          icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: MyColor.hintTextColor,
                              size: 20),
                          onPressed: _toggle)
                      : widget.isIcon
                          ? IconButton(
                              onPressed: widget.onSuffixTap,
                              icon: Icon(
                                widget.isSearch
                                    ? Icons.search_outlined
                                    : widget.isCountryPicker
                                        ? Icons.arrow_drop_down_outlined
                                        : Icons.camera_alt_outlined,
                                size: 25,
                                color: MyColor.getPrimaryColor(),
                              ),
                            )
                          : null
                  : null,
            ),
            onFieldSubmitted: (text) => widget.nextFocus != null
                ? FocusScope.of(context).requestFocus(widget.nextFocus)
                : null,
            onChanged: (text) => widget.onChanged!(text),
          );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
