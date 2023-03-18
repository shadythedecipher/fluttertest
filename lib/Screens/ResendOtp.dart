import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../GlobalStyle/GlobalVariables.dart';
import '../UtilsFunctions/Utils.dart';
import '../Widgets/Button.dart';
import '../Widgets/TextField.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MainScreen.dart';
import 'PasswordRenter.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key,}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var deviceSize= MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
        Get.back();
      }),),
      body: Container(
      margin: EdgeInsets.only(
        top: deviceSize.height * 0.009,
      ),
      padding: EdgeInsets.only(
          right: deviceSize.width * 0.05,
          left: deviceSize.width * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009),
          Text("Forgot your password?",style: GlobalVariables.myTheme2.textTheme.bodyMedium,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009),
          Text("Please provide an account email and we will send a 4-digit confirmation code to reset the password. Make sure you enter correct code.",style: GlobalVariables.myTheme2.textTheme.displaySmall,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009,),
          SizedBox(height: deviceSize.height*0.009),
          SizedBox(
            height: 90,
            child: Padding(
              padding:  const EdgeInsets.only(right: 10),
              child:  CustomTextField(
                controller: email,
                hintText: " Enter email",
                val: false,
                labelText: 'Email',
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
              if (isConnected) {
                if(email.text.isEmpty){
                  // ignore: use_build_context_synchronously
                  showSnackBarForSuccess(context, "Please enter email");
                  return;
                }
                // validation
                setState(() {
                  isLoading = true;
                });
                String url = "https://kikundidevbackend.azurewebsites.net/api/user/reset-password-request";
                final Map<String, String> headers = {"Content-Type": "application/json"};

                final Map<String, String> body = {
                  "email": email.text,
                };
                final String jsonBody = json.encode(body);
                try{
                  final http.Response response = await http.post(Uri.parse(url), headers: headers, body: jsonBody);
                  setState(() {
                    isLoading = false;
                  });
                  if (response.statusCode == 200) {

                    final Map<String, dynamic> data = json.decode(response.body);
                    // ignore: use_build_context_synchronously
                    showSnackBarForSuccess(context, "Email sent successfully");
                    Get.off( PasswordRenter(email: email.text,));
                  } else {
                    final Map<String, dynamic> data = json.decode(response.body);
                    if(data['hasError']){
                      // ignore: use_build_context_synchronously
                      showSnackBarForSuccess(context, data['errors']);
                    }
                    // ignore: use_build_context_synchronously
                    showSnackBarForSuccess(context, data['successMessage']);
                  }
                }catch(e){

                  // // ignore: use_build_context_synchronously
                  // showSnackBarForError1(context, );
                }

              }else{
                // ignore: use_build_context_synchronously
                showSnackBarForError1(context, "No internet");
              }
            },
            widgetChild: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    :  Text(
                  "Continue",
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
        ],),
    ),));
  }
}
