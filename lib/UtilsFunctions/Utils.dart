import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertest/GlobalStyle/GlobalVariables.dart';
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
     showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      shape: StadiumBorder(),
    ),
  );
}
void showSnackBarForCart(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(

    SnackBar(
      content: Text(text, style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center),
      backgroundColor: GlobalVariables.callToAction,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      shape: StadiumBorder(),
      elevation: 30,
      duration: Duration(milliseconds: 250),
    ),

  );
}

void showSnackBarForError(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(

    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline_outlined, color: Colors.red,),
                Text(text, style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: GlobalVariables.error,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      shape: const StadiumBorder(),
      duration: const Duration(milliseconds: 2050),
    ),

  );
}
void showSnackBarForSuccess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.task_alt, color: GlobalVariables.buttonColor,),
                Text(text, style: const TextStyle(color: GlobalVariables.buttonColor),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: GlobalVariables.blackColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      shape: const StadiumBorder(),
      duration: const Duration(milliseconds: 2050),
    ),

  );

}

void showSnackBarForError1(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red,),
                const SizedBox(width: 20,),
                Text(text, style:GlobalVariables.myTheme2.textTheme.displayLarge,
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),

      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      shape: const StadiumBorder(),
      duration: const Duration(milliseconds: 2050),
    ),

  );

}

// void showSnackBar(ScaffoldMessengerState scaffoldMessengerState, String text) {
//   scaffoldMessengerState.showSnackBar(
//     SnackBar(
//       content: Text(text),
//     ),
//   );
// }