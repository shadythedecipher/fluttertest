import 'package:flutter/material.dart';
import 'package:fluttertest/GlobalStyle/GlobalVariables.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading:  IconButton(icon:const Icon( Icons.arrow_back_ios_new),onPressed: (){
          Get.back();
        },),
      ),
      body: Column(children: [
      Text("Enter email ",style: GlobalVariables.myTheme.textTheme.displayLarge,),

    ],),));
  }
}
