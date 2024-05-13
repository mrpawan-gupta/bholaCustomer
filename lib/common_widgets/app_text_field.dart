import "package:flutter/material.dart";
import "package:flutter/services.dart";

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.keyboardType,
    required this.textCapitalization,
    required this.textInputAction,
    required this.readOnly,
    required this.obscureText,
    required this.maxLines,
    required this.maxLength,
    required this.onChanged,
    required this.onTap,
    required this.inputFormatters,
    required this.enabled,
    required this.autofillHints,
    required this.hintText,
    required this.hintStyle,
    required this.prefixIcon,
    required this.suffixIcon,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final Iterable<String>? autofillHints;
  final String hintText;
  final TextStyle hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).buttonTheme.colorScheme!.primary;
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      readOnly: readOnly,
      obscureText: obscureText,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onTap: onTap,
      inputFormatters: inputFormatters,
      enabled: enabled,
      cursorColor: primary,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: hintStyle,
        floatingLabelStyle: TextStyle(color: primary),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
