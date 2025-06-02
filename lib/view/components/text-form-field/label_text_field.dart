// ignore_for_file: deprecated_member_use

import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/view/components/text/label_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabelTextField extends StatefulWidget {
  final bool needOutline;
  final String labelText;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final TextInputAction inputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final int maxLines;
  final bool isRequired;
  final bool isAttachment;
  final bool hideLabel;
  final double radius;
  final EdgeInsetsGeometry contentPadding;
  final Color fillColor;
  final Color labelTextColor;
  final Color hintTextColor;
  final TextStyle? labelTextStyle;
  final TextStyle? inputTextStyle;
  final VoidCallback? onTap;

  const LabelTextField({
    super.key,
    this.needOutline = true,
    required this.labelText,
    this.readOnly = false,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isAttachment = false,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.isRequired = false,
    this.hideLabel = false,
    this.radius = Dimensions.defaultRadius,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding =
        const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
    this.fillColor = MyColor.textFieldColor,
    this.hintTextColor = MyColor.hintTextColor,
    this.labelTextColor = MyColor.labelTextColor,
    this.labelTextStyle,
    this.inputTextStyle,
    this.onTap,
  });

  @override
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.needOutline
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.hideLabel != true) ...[
                LabelText(
                  text: widget.labelText.toString().tr,
                  isRequired: widget.isRequired,
                  textStyle: widget.labelTextStyle ??
                      Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: Dimensions.textToTextSpace),
              ],
              TextFormField(
                  maxLines: widget.maxLines,
                  readOnly: widget.readOnly,
                  style: widget.inputTextStyle ??
                      regularDefault.copyWith(
                          color: Theme.of(context).primaryColor),
                  cursorColor: MyColor.getTextColor(),
                  controller: widget.controller,
                  autofocus: false,
                  textInputAction: widget.inputAction,
                  enabled: widget.isEnable,
                  focusNode: widget.focusNode,
                  validator: widget.validator,
                  keyboardType: widget.textInputType,
                  obscureText: widget.isPassword ? obscureText : false,
                  decoration: InputDecoration(
                    contentPadding: widget.contentPadding,
                    hintText: widget.hintText?.tr ?? '',
                    hintStyle:
                        regularDefault.copyWith(color: widget.hintTextColor),
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0.5, color: MyColor.textFieldColor),
                        borderRadius: BorderRadius.circular(widget.radius)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0.5, color: MyColor.textFieldColor),
                        borderRadius: BorderRadius.circular(widget.radius)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0.5, color: MyColor.textFieldColor),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.isPassword
                        ? UnconstrainedBox(
                            child: Material(
                              color: Colors.transparent,
                              shape: const CircleBorder(),
                              child: InkWell(
                                focusColor: MyColor.naturalLight,
                                autofocus: false,
                                canRequestFocus: false,
                                onTap: _toggle,
                                child: Container(
                                  padding:
                                      const EdgeInsets.all(Dimensions.space5),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  height: 25,
                                  width: 25,
                                  child: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: MyColor.hintTextColor,
                                      size: 20),
                                ),
                              ),
                            ),
                          )
                        : widget.suffixIcon,
                  ),
                  onFieldSubmitted: (text) => widget.nextFocus != null
                      ? FocusScope.of(context).requestFocus(widget.nextFocus)
                      : null,
                  onChanged: (text) => widget.onChanged!(text),
                  onTap: widget.onTap),
            ],
          )
        : widget.isAttachment
            ? TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: widget.inputTextStyle ??
                    regularDefault.copyWith(color: MyColor.getTextColor()),
                cursorColor: MyColor.getTextColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,
                decoration: InputDecoration(
                  contentPadding: widget.contentPadding,
                  hintText: widget.hintText?.tr ?? '',
                  hintStyle:
                      regularDefault.copyWith(color: widget.hintTextColor),
                  fillColor: widget.fillColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5,
                          color: MyColor.getTextFieldDisableBorder()),
                      borderRadius: BorderRadius.circular(widget.radius)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5,
                          color: MyColor.getTextFieldDisableBorder()),
                      borderRadius: BorderRadius.circular(widget.radius)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.5, color: MyColor.getTextFieldDisableBorder()),
                    borderRadius: BorderRadius.circular(widget.radius),
                  ),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.isPassword
                      ? UnconstrainedBox(
                          child: Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            child: InkWell(
                              focusColor: MyColor.naturalLight,
                              autofocus: false,
                              canRequestFocus: false,
                              onTap: _toggle,
                              child: Container(
                                padding:
                                    const EdgeInsets.all(Dimensions.space5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyColor.getPrimaryColor()),
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ),
                        )
                      : widget.suffixIcon,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null
                    ? FocusScope.of(context).requestFocus(widget.nextFocus)
                    : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.hideLabel != true) ...[
                    LabelText(
                      text: widget.labelText.toString().tr,
                      isRequired: widget.isRequired,
                      textStyle: widget.labelTextStyle ??
                          Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: Dimensions.textToTextSpace),
                  ],
                  TextFormField(
                      maxLines: widget.maxLines,
                      readOnly: widget.readOnly,
                      style: widget.inputTextStyle ??
                          regularDefault.copyWith(
                              color: MyColor.getTextColor()),
                      cursorColor: MyColor.getTextColor(),
                      controller: widget.controller,
                      autofocus: false,
                      textInputAction: widget.inputAction,
                      enabled: widget.isEnable,
                      focusNode: widget.focusNode,
                      validator: widget.validator,
                      keyboardType: widget.textInputType,
                      obscureText: widget.isPassword ? obscureText : false,
                      decoration: InputDecoration(
                        contentPadding: widget.contentPadding,
                        hintText: widget.hintText?.tr ?? '',
                        hintStyle: regularDefault.copyWith(
                            color: widget.hintTextColor),
                        fillColor: widget.fillColor,
                        filled: true,
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: MyColor.getTextFieldDisableBorder())),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: MyColor.getTextFieldEnableBorder())),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: MyColor.getTextFieldDisableBorder())),
                        prefixIcon: widget.prefixIcon,
                        suffixIcon: widget.isPassword
                            ? UnconstrainedBox(
                                child: Material(
                                  color: Colors.transparent,
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    splashColor: MyColor.getPrimaryColor()
                                        .withOpacity(0.1),
                                    onTap: _toggle,
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                          Dimensions.space5),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      height: 25,
                                      width: 25,
                                      child: Icon(
                                          obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: MyColor.hintTextColor,
                                          size: 20),
                                    ),
                                  ),
                                ),
                              )
                            : widget.suffixIcon,
                      ),
                      onFieldSubmitted: (text) => widget.nextFocus != null
                          ? FocusScope.of(context)
                              .requestFocus(widget.nextFocus)
                          : null,
                      onChanged: (text) => widget.onChanged!(text),
                      onTap: widget.onTap),
                ],
              );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
