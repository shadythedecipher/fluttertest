import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertest/GlobalStyle/GlobalVariables.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../UtilsFunctions/Utils.dart';
import '../Widgets/Button.dart';
import 'MainScreen.dart';
class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var deviceSize= MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(body: Container(
      margin:  EdgeInsets.only(top: deviceSize.height*0.1, bottom: deviceSize.height*0.1),
      padding:  EdgeInsets.only(right:  deviceSize.width*0.05,left:  deviceSize.width*0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        Text("Check your email",style: GlobalVariables.myTheme2.textTheme.bodyMedium,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009),
        Text("We,ve sent a 4-digit confirmation code to ${widget.email}. Make sure you enter correct code.",style: GlobalVariables.myTheme2.textTheme.displaySmall,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009),
          SizedBox(
            height: 90,
            child: Padding(
              padding:  const EdgeInsets.only(right: 10),
              child: OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width*0.9,
                fieldWidth: 50,
                style: const TextStyle(
                    fontSize: 17
                ),
                keyboardType: TextInputType.number,
                onCompleted: (pin) {
                  print("Completed: $pin");
                },
                textFieldAlignment: MainAxisAlignment.spaceAround,
                outlineBorderRadius: 10,
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: GlobalVariables.otp,
                ),
              ),

            ),
          ),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009),
          CustomButton(
                () async {
              final bool isConnected =
              await InternetConnectionChecker().hasConnection;
              if (!isConnected) {

                // validation
                setState(() {
                  isLoading = true;
                });
                String url = "https://kikundidevbackend.azurewebsites.net/api/user/create";
                final Map<String, String> headers = {"Content-Type": "application/json"};

                final Map<String, String> body = {
                  "email": widget.email,
                  "otp": "8990",
                };
                final String jsonBody = json.encode(body);
                try{
                  final http.Response response = await http.post(Uri.parse(url), headers: headers, body: jsonBody);
                  setState(() {
                    isLoading = false;
                  });
                  print(response.body);
                  if (response.statusCode == 200) {

                    final Map<String, dynamic> data = json.decode(response.body);
                    showSnackBarForSuccess(context, data['successMessage']);
                    Get.off(mainScreen());
                  } else {
                    final ress = jsonDecode(response.body);
                    print("------------------------"+ ress);
                    showSnackBar(context, response.body);
                  }
                }catch(e){
                  print(e);
                  Get.off(mainScreen());

                }

              }else{
                showSnackBarForError1(context, "No internet");
              }
            },
            widgetChild: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(
                  "Verify",
                  style:  GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white
                  ),),
              ],
            ),
            width: deviceSize.width*0.9,
            height: 50,
            buttonColor: GlobalVariables.blackColor,
          ),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
            const Text("Didn’t recieve code?"),
            GestureDetector(
              child: const Text(" Resend Code",style: TextStyle(color: GlobalVariables.retryAction,
              fontWeight: FontWeight.bold),),
              onTap: () async {
                final bool isConnected =
                    await InternetConnectionChecker().hasConnection;
                if (isConnected) {

                  // validation
                  setState(() {
                    isLoading = true;
                  });
                  String url = "https://kikundidevbackend.azurewebsites.net/api/user/resendVerifyOTP";
                  final Map<String, String> headers = {"Content-Type": "application/json"};

                  final Map<String, String> body = {
                    "email": widget.email,
                  };
                  final String jsonBody = json.encode(body);
                  try{
                    final http.Response response = await http.post(Uri.parse(url), headers: headers, body: jsonBody);
                    print(response.body);
                    if (response.statusCode == 200) {

                      final Map<String, dynamic> data = json.decode(response.body);
                      showSnackBarForSuccess(context, data['successMessage']);
                      Get.off(mainScreen());
                    } else {
                      final ress = jsonDecode(response.body);
                      print("------------------------"+ ress);
                      showSnackBar(context, response.body);
                    }
                  }catch(e){
                    print(e);
                    Get.off(mainScreen());

                  }

                }else{
                  showSnackBarForError1(context, "No internet");
                }
              },
            )
          ],)
      ],),
    ),));
  }
}
