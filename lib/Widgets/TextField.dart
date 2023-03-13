import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

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
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: InputBorder.none,
        suffixIcon: icon,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.all(20.0),
        focusedBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(0, 36, 10, 10)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
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