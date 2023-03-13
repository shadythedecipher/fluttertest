import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/GlobalStyle/GlobalVariables.dart';
import 'package:fluttertest/Models/APIresponse/LoginAPIresponse.dart';
import 'package:fluttertest/Models/Dto/LoginDto.dart';
import 'package:fluttertest/Screens/RegisterView.dart';
import 'package:fluttertest/Screens/ResertPassword.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'Screens/MainScreen.dart';
import 'UtilsFunctions/Utils.dart';
import 'Widgets/Button.dart';
import 'Widgets/TextField.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kikundi app',
      debugShowCheckedModeBanner: false,
      theme: GlobalVariables.myTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool isLoading = false;
  bool passwordVisibility = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    print(deviceSize);
    return SafeArea(
      child: Scaffold(
        body: deviceSize.height > 750
            ? SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                      top: deviceSize.height * 0.1,
                      bottom: deviceSize.height * 0.1),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 90,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/kikundi.png"),
                                    fit: BoxFit.contain),
                              ),
                            ),
                            Text(
                              "Kikundi",
                              style: GlobalVariables
                                  .myTheme.textTheme.displayLarge,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.06,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: deviceSize.width * 0.05,
                              left: deviceSize.width * 0.08),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login",
                                style: GlobalVariables
                                    .myTheme.textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.06,
                              ),
                              CustomTextField(
                                controller: emailController,
                                hintText: " Enter Email or PhoneNumber",
                                val: false,
                                labelText: 'Email or PhoneNumber',
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(height: deviceSize.height * 0.009),
                              CustomTextField(
                                controller: controllerPassword,
                                hintText: "Enter Password",
                                val: !passwordVisibility,
                                labelText: 'Password',
                                icon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (passwordVisibility == false) {
                                          passwordVisibility = true;
                                        } else {
                                          passwordVisibility = false;
                                        }
                                      });
                                    },
                                    icon: Icon(passwordVisibility
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(height: deviceSize.height * 0.009),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceSize.width * 0.5),
                                child: GestureDetector(
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: GlobalVariables.callToAction,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    Get.to(const ForgotPassword());
                                  },
                                ),
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),

                              // Padding(
                              //   padding:  EdgeInsets.only(left: deviceSize.width*0.39),
                              //   child: DottedBorder(
                              //       dashPattern: const [6, 3, 2, 3],
                              //       child: const Icon(Icons.face_2)
                              //   ),
                              // ),

                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              // SizedBox(height: deviceSize.height*0.009,),
                              // SizedBox(height: deviceSize.height*0.009,),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),

                              CustomButton(
                                () async {
                                  final bool isConnected =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (isConnected) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    String url =
                                        "https://kikundidevbackend.azurewebsites.net/api/user/login";
                                    final Map<String, String> headers = {
                                      "Content-Type": "application/json"
                                    };
                                    final Map<String, String> body = {
                                      "email": emailController.text,
                                      "password": controllerPassword.text
                                    };
                                    final String jsonBody = json.encode(body);
                                    final http.Response response =
                                        await http.post(Uri.parse(url),
                                            headers: headers, body: jsonBody);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print(response.body);
                                    if (response.statusCode == 200) {
                                      final Map<String, dynamic> data =
                                          json.decode(response.body);
                                      showSnackBarForSuccess(
                                          context, data['successMessage']);
                                      Get.off(mainScreen());
                                    } else {
                                      final ress = jsonDecode(response.body);
                                      print("------------------------" + ress);
                                      showSnackBar(context, response.body);
                                    }
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    showSnackBar(context, 'No internet');
                                  }
                                },
                                widgetChild: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            "Log in",
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                  ],
                                ),
                                width: deviceSize.width * 0.9,
                                height: 50,
                                buttonColor: GlobalVariables.buttonColor,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),

                              CustomButton(
                                () async {
                                  Get.off((const RegistrationScreen()));
                                },
                                widgetChild: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign Up",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                                width: deviceSize.width * 0.9,
                                height: 50,
                                buttonColor: GlobalVariables.blackColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    top: deviceSize.height * 0.1,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 90,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/kikundi.png"),
                                    fit: BoxFit.contain),
                              ),
                            ),
                            Text(
                              "Kikundi",
                              style: GlobalVariables
                                  .myTheme.textTheme.displayLarge,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.009,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: deviceSize.width * 0.05,
                              left: deviceSize.width * 0.08),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login",
                                style: GlobalVariables
                                    .myTheme.textTheme.displayLarge,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.006,
                              ),
                              CustomTextField(
                                controller: emailController,
                                hintText: " Enter Email or PhoneNumber",
                                val: false,
                                labelText: 'Email or PhoneNumber',
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(height: deviceSize.height * 0.009),
                              CustomTextField(
                                controller: controllerPassword,
                                hintText: "Enter Password",
                                val: !passwordVisibility,
                                labelText: 'Password',
                                icon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (passwordVisibility == false) {
                                          passwordVisibility = true;
                                        } else {
                                          passwordVisibility = false;
                                        }
                                      });
                                    },
                                    icon: Icon(passwordVisibility
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(height: deviceSize.height * 0.009),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceSize.width * 0.5),
                                child: GestureDetector(
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: GlobalVariables.callToAction,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    Get.to(const ForgotPassword());
                                  },
                                ),
                              ),
                              // SizedBox(height: deviceSize.height*0.009,),
                              // SizedBox(height: deviceSize.height*0.009,),
                              // SizedBox(height: deviceSize.height*0.009,),
                              // SizedBox(height: deviceSize.height*0.009,),
                              // SizedBox(height: deviceSize.height*0.009,),
                              // SizedBox(height: deviceSize.height*0.009,),
                              // SizedBox(height: deviceSize.height*0.009,),
                              // Padding(
                              //   padding:  EdgeInsets.only(left: deviceSize.width*0.39),
                              //   child: DottedBorder(
                              //       dashPattern: const [6, 3, 2, 3],
                              //       child: const Icon(Icons.face_2)
                              //   ),
                              // ),

                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              // SizedBox(height: deviceSize.height*0.009,),
                              // SizedBox(height: deviceSize.height*0.009,),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),

                              CustomButton(
                                () async {
                                  final bool isConnected =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (isConnected) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    login user = login(
                                      email: emailController.text,
                                      password: controllerPassword.text,
                                    );
                                    String url =
                                        "https://kikundidevbackend.azurewebsites.net/api/user/login";
                                    final Map<String, String> headers = {
                                      "Content-Type": "application/json"
                                    };
                                    // LoginAPIresponse res = ;
                                    final Map<String, String> body = {
                                      "email": emailController.text,
                                      "password": controllerPassword.text
                                    };
                                    final String jsonBody = json.encode(body);
                                    final http.Response response =
                                        await http.post(Uri.parse(url),
                                            headers: headers, body: jsonBody);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print(response.body);
                                    if (response.statusCode == 200) {
                                      final Map<String, dynamic> data =
                                          json.decode(response.body);
                                      showSnackBarForSuccess(
                                          context, data['successMessage']);
                                      Get.off(mainScreen());
                                    } else {
                                      final ress = jsonDecode(response.body);
                                      print("------------------------" + ress);
                                      showSnackBar(context, response.body);
                                    }
                                  } else {
                                    showSnackBar(context, 'No internet');
                                  }
                                },
                                widgetChild: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            "Log in",
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                  ],
                                ),
                                width: deviceSize.width * 0.9,
                                height: 50,
                                buttonColor: GlobalVariables.buttonColor,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.009,
                              ),

                              CustomButton(
                                () async {
                                  Get.off(const RegistrationScreen());
                                },
                                widgetChild: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign Up",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                                width: deviceSize.width * 0.9,
                                height: 50,
                                buttonColor: GlobalVariables.blackColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
