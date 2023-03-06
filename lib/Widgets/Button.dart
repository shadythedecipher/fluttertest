import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(this.onPressed,
      {Key? key,
        required this.widgetChild,
        required this.width,
        required this.height,
        required this.buttonColor})
      : super(key: key);
  final VoidCallback onPressed;
  final Widget widgetChild;
  final double width;
  final double height;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
            Size(width, height),
          ),
          backgroundColor: MaterialStateProperty.all(buttonColor),
      ),
      child: widgetChild,
    );
  }
}
