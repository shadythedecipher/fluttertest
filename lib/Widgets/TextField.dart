import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final int maxLines;
  final bool val;
  final bool? valueEnabled;
  final double? width;
  final double? height;
  final IconButton? icon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    required this.val, required this.labelText, this.icon, this.width, this.height, this.valueEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        border: InputBorder.none,
        suffixIcon: icon,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
      obscureText: val,
      enableSuggestions: false,
      autocorrect: false,
      enabled: valueEnabled,
    );

  }
}