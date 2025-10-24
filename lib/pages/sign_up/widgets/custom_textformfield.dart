import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/utils.dart';

class CustomTextformfield extends StatelessWidget {
  const CustomTextformfield({
    super.key,
    this.inputFormatters,
    this.controller,
    this.keyboardType,
    this.autovalidateMode,
    this.style,
    this.enabled,
    this.hintText,
    this.validator,
    this.onChanged,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.errorText,
  });
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final TextStyle? style;
  final bool? enabled;
  final String? hintText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = enabled ?? true;
    return TextFormField(
      enabled: enabled,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      validator: validator,
      onChanged: onChanged,
      cursorColor: Colors.white,
      cursorErrorColor: Colors.white,
      obscureText: obscureText ?? false,
      style: TextStyle(
        color: isEnabled ? Colors.white : Colors.white54,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: isEnabled ? ColorString.deepSea : Colors.grey.shade600,
        prefix: prefix,
        prefixIcon: prefixIcon,
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: hintText,
        hintStyle: TextStyle(
          color: isEnabled ? Colors.white54 : Colors.white54,
          overflow: TextOverflow.ellipsis
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: isEnabled ? ColorString.white : Colors.grey.shade500,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none
        )
      )
    );
  }
}