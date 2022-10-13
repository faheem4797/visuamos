import 'package:flutter/material.dart';

import '../colors/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.textInputType,
    this.readOnly,
    this.validator,
    this.onTap,
    this.obscureText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool? readOnly;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType ?? TextInputType.name,
      readOnly: readOnly ?? false,
      validator: validator,
      onTap: onTap,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: darkBlue, width: 3),
          ),
          hintText: hintText,
          labelText: labelText,
          border: const OutlineInputBorder()),
    );
  }
}
