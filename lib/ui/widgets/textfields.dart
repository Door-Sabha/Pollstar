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
    super.key,
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
  });

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
