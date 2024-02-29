import 'package:flutter/material.dart';

import '../../utils/theme/colors.dart';
import '../../utils/theme/styles.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final int? maxLength;
  final bool readOnly;
  final bool obscureText;
  final Function? onTap;
  final Function? onChanged;

  const MyTextField({
    Key? key,
    this.textEditingController,
    this.hintText = "",
    this.labelText = "",
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.textAlign = TextAlign.justify,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.maxLength,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greenColor,
          width: 2,
        ),
      ),
      child: TextField(
        style: AppStyle.textStyleInputType,
        controller: textEditingController,
        keyboardType: keyboardType,
        enabled: enabled,
        textAlign: textAlign,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        readOnly: readOnly,
        maxLength: maxLength,
        obscureText: obscureText,
        onTap: () => onTap?.call(),
        onChanged: (value) => (onChanged != null) ? onChanged!(value) : null,
        decoration: InputDecoration(
          prefixIcon: (prefixIcon != null)
              ? Icon(
                  prefixIcon,
                  color: AppColors.textHintColor,
                )
              : null,
          suffixIcon: (suffixIcon != null)
              ? Icon(
                  suffixIcon,
                  color: AppColors.textHintColor,
                )
              : null,
          border: InputBorder.none,
          filled: true,
          hintText: hintText,
          labelText: (labelText.isNotEmpty) ? labelText : null,
          hintStyle: AppStyle.textStyleHint,
          fillColor: AppColors.inputBackgroundColor,
          counterText: "",
          counterStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MyOtpTextField extends StatelessWidget {
  const MyOtpTextField({
    Key? key,
    this.textEditingController,
    this.onForward,
    this.onBackward,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final Function? onForward;
  final Function? onBackward;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 48,
      height: 48,
      child: TextField(
        controller: textEditingController,
        focusNode: focusNode,
        maxLength: 1,
        maxLines: 1,
        style: AppStyle.textStylePasscodeInputType,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        obscureText: false,
        onChanged: (value) {
          if (value.length == 1) {
            onForward?.call();
          } else {
            onBackward?.call();
          }
        },
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          hintStyle: AppStyle.textStyleHint,
          fillColor: AppColors.textColorLight,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.themeColor,
              width: 10,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.themeColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.themeColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
