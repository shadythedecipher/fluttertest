import 'dart:convert';

import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart' as passer;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../GlobalStyle/GlobalVariables.dart';
import '../UtilsFunctions/Utils.dart';
import '../Widgets/Button.dart';
import '../Widgets/TextField.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';

import '../main.dart';
import 'MainScreen.dart';
import 'OtpVerificationScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool isLoading = false;
  var numberOfuser = '';
  final _formKey1 = GlobalKey<FormState>();
  String _phoneNumber = '';
  bool passwordVisibility = false;
  List<String> includedCountries = ['TZ'];
  final passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final TextEditingController phoneNumber = TextEditingController();
    String initialCountry = 'TZ';
    PhoneNumber number = PhoneNumber(isoCode: 'TZ');
    var deviceSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: deviceSize.height < 600
          ? Container(
              // margin: EdgeInsets.only(
              //   top: deviceSize.height * 0.05,
              // ),
              padding: EdgeInsets.only(
                  right: deviceSize.width * 0.05,
                  left: deviceSize.width * 0.08),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: GlobalVariables.myTheme.textTheme.displayLarge,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.02,
                    ),
                    CustomTextField(
                      controller: fullNameController,
                      hintText: " Enter full name ",
                      val: false,
                      labelText: 'Full name',
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),
                    CustomTextField(
                      controller: email,
                      hintText: " Enter email",
                      val: false,
                      labelText: 'Email',
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),
                    Form(
                      key: _formKey1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          hintText: "Enter phone number",
                          border: InputBorder.none,
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
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          final tanzanianRegex = RegExp(r'^255\d{9}$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          } else if (!tanzanianRegex.hasMatch(value)) {
                            if (value.length > 3 &&
                                value.length < 12 &&
                                !tanzanianRegex.hasMatch(value)) {
                              return 'Phone number too short';
                            }
                            return 'Please enter a valid Tanzanian phone number 255';
                          }
                          return null;
                        },
                        maxLines: 1,
                        enableSuggestions: false,
                        autocorrect: false,
                        onFieldSubmitted: (value) {
                          // do something when the "done" button is pressed
                          // you can leave this method empty if you don't want to do anything
                        },
                      ),
                    ),
                    // TextFormField(
                    //   controller: phoneNumber,
                    //   decoration: InputDecoration(
                    //     labelText: 'Phone number',
                    //     hintText: 'Enter phone number',
                    //     border: InputBorder.none,
                    //     filled: true,
                    //     fillColor: Colors.grey[200],
                    //     contentPadding: const EdgeInsets.all(20.0),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide:
                    //       const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide:
                    //       const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     focusedErrorBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(
                    //           color: Color.fromARGB(0, 36, 10, 10)),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     errorBorder: OutlineInputBorder(
                    //       borderSide:
                    //       const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //   ),
                    //   keyboardType: TextInputType.phone,
                    //   validator: (val) {
                    //     final frPhone0 = PhoneNumber.parse(phoneNumber.text);
                    //     final valid = frPhone0.isValid();
                    //     PhoneNumberType type ;
                    //     frPhone0.isValidLength(type: PhoneNumberType.mobile);
                    //     if (val == null || val.isEmpty) {
                    //       return 'Enter your phone Number';
                    //     }else if(!valid&&frPhone0.isoCode!=IsoCode.TZ){
                    //       return 'Enter a proper Tanzanian number';
                    //     }
                    //
                    //     return null;
                    //   },
                    //   obscureText: false,
                    //   enableSuggestions: false,
                    //   autocorrect: false,
                    // ),
                    //      PhoneNumberInput(
                    //       initialCountry: 'TZ',
                    //       controller: phoneNumber,
                    //       allowPickFromContacts: false,
                    //       includedCountries: includedCountries,
                    //       countryListMode: CountryListMode.dialog,
                    //       searchHint: "Tan",
                    //       errorText: 'Please check you number',
                    //     ),

                    // InternationalPhoneNumberInput(
                    //   onInputChanged: (PhoneNumber number) {
                    //     if (number.phoneNumber!.length >= 13) {
                    //       setState(() {
                    //         numberOfuser = number.phoneNumber!;
                    //       });
                    //     } else {}
                    //   },
                    //   onInputValidated: (bool value) {
                    //     print(value);
                    //   },
                    //   // selectorConfig: const SelectorConfig(
                    //   //   selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    //   // ),
                    //   ignoreBlank: false,
                    //   autoValidateMode: AutovalidateMode.disabled,
                    //   selectorTextStyle: TextStyle(color: Colors.black),
                    //   initialValue: number,
                    //   countries: ['TZ'],
                    //   maxLength: 9,
                    //   hintText: '743625473',
                    //   textFieldController: phoneNumber,
                    //   // formatInput: true,
                    //   keyboardType: TextInputType.number,
                    //   // inputBorder: const OutlineInputBorder(),
                    //   onSaved: (PhoneNumber number) {
                    //     print('On Saved: $number');
                    //     setState(() {
                    //       numberOfuser = number.phoneNumber!;
                    //       print("---------============$numberOfuser");
                    //     });
                    //     print("---------============@@@@@@@@@@@@@@@@@@@@@@$numberOfuser");
                    //   },
                    // ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),
                    // CustomTextField(
                    //   controller: controllerPassword,
                    //   hintText: "Enter Password",
                    //   val: !passwordVisibility,
                    //   labelText: 'Password',
                    //   icon: IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           if (passwordVisibility == false) {
                    //             passwordVisibility = true;
                    //           } else {
                    //             passwordVisibility = false;
                    //           }
                    //         });
                    //       },
                    //       icon: Icon(passwordVisibility
                    //           ? Icons.visibility
                    //           : Icons.visibility_off)),
                    // ),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: "Enter password",
                          border: InputBorder.none,
                          suffixIcon: IconButton(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (!passwordRegex.hasMatch(value)) {
                            return 'Password must be characters';
                          }
                          return null;
                        },
                        maxLines: 1,
                        obscureText: !passwordVisibility,
                        enableSuggestions: false,
                        autocorrect: false,
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
                    SizedBox(height: deviceSize.height * 0.009),
                    // Padding(
                    //   padding:  EdgeInsets.only(left: deviceSize.width*0.5),
                    //   child: const Text("Forgot Password?",style: TextStyle(color: GlobalVariables.callToAction,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold),),
                    // ),
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
                    Row(
                      children: [
                        Text(
                          "By signing up you agree to our",
                          style:
                              GlobalVariables.myTheme2.textTheme.displaySmall,
                        ),
                        Text(
                          " Terms & ",
                          style:
                              GlobalVariables.myTheme2.textTheme.displayMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Condition ",
                          style:
                              GlobalVariables.myTheme2.textTheme.displayMedium,
                        ),
                        Text(
                          "and ",
                          style:
                              GlobalVariables.myTheme2.textTheme.displaySmall,
                        ),
                        Text(
                          "Privacy Policy.",
                          style:
                              GlobalVariables.myTheme2.textTheme.displayMedium,
                        ),
                        const Text(
                          "*",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ],
                    ),
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
                            await InternetConnectionChecker().hasConnection;
                        if (isConnected) {
                          setState(() {
                            isLoading = true;
                          });
                          var trimed = numberOfuser.substring(1);
                          print("099999999999999999" + trimed);
                          String url =
                              "https://kikundidevbackend.azurewebsites.net/api/user/create";
                          final Map<String, String> headers = {
                            "Content-Type": "application/json"
                          };
                          // final frPhone0 = PhoneNumber.parse(phoneNumber.text);
                          final Map<String, String> body = {
                            "firstName": fullNameController.text,
                            "email": email.text,
                            "phone": trimed,
                            "password": controllerPassword.text
                          };
                          final String jsonBody = json.encode(body);
                          try {
                            final http.Response response = await http.post(
                                Uri.parse(url),
                                headers: headers,
                                body: jsonBody);
                            setState(() {
                              isLoading = false;
                            });
                            print(response.body);
                            if (response.statusCode == 200) {
                              final Map<String, dynamic> data =
                                  json.decode(response.body);
                              showSnackBarForSuccess(
                                  context, data['successMessage']);
                              // Get.off(OtpVerificationScreen(email: email.text));
                            } else {
                              final Map<String, dynamic> data =
                                  json.decode(response.body);
                              print(data);
                              if (data['errors'].toString().length > 30) {
                                print(data['errors']);
                                // ignore: use_build_context_synchronously
                                showSnackBar(context,
                                    "please enter an email in the given field");
                              } else {
                                // ignore: use_build_context_synchronously
                                showSnackBar(context, data['errors']);
                              }
                            }
                          } catch (e) {
                            print(e);
                            // Get.off(OtpVerificationScreen(email: email.text));
                          }

                          //
                          // // validation
                        } else {
                          showSnackBarForError1(context, "No internet");
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
                                  "Continue",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.white),
                                ),
                        ],
                      ),
                      width: deviceSize.width * 0.9,
                      height: 50,
                      buttonColor: GlobalVariables.blackColor,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already signed up ?",
                          style:
                              GlobalVariables.myTheme2.textTheme.displaySmall,
                        ),
                        GestureDetector(
                          child: Text(
                            " Login  ",
                            style: GlobalVariables.myTheme2.textTheme.bodyLarge,
                          ),
                          onTap: () {
                            Get.off(const MyHomePage());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(
                top: deviceSize.height * 0.09,
              ),
              padding: EdgeInsets.only(
                  right: deviceSize.width * 0.05,
                  left: deviceSize.width * 0.08),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: GlobalVariables.myTheme.textTheme.displayLarge,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.02,
                    ),
                    CustomTextField(
                      controller: fullNameController,
                      hintText: " Enter full name ",
                      val: false,
                      labelText: 'Full name',
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),
                    CustomTextField(
                      controller: email,
                      hintText: " Enter email",
                      val: false,
                      labelText: 'Email',
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),
                    // TextFormField(
                    //   controller: phoneNumber,
                    //   decoration: InputDecoration(
                    //     labelText: 'Phone number',
                    //     hintText: 'Enter phone number',
                    //     border: InputBorder.none,
                    //     filled: true,
                    //     fillColor: Colors.grey[200],
                    //     contentPadding: const EdgeInsets.all(20.0),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide:
                    //       const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide:
                    //       const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     focusedErrorBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(
                    //           color: Color.fromARGB(0, 36, 10, 10)),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     errorBorder: OutlineInputBorder(
                    //       borderSide:
                    //       const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //   ),
                    //   keyboardType: TextInputType.phone,
                    //   validator: (val) {
                    //     final frPhone0 = PhoneNumber.parse(phoneNumber.text);
                    //     final valid = frPhone0.isValid();
                    //     PhoneNumberType type ;
                    //     frPhone0.isValidLength(type: PhoneNumberType.mobile);
                    //     if (val == null || val.isEmpty) {
                    //       return 'Enter your phone Number';
                    //     }else if(!valid&&frPhone0.isoCode!=IsoCode.TZ){
                    //       return 'Enter a proper Tanzanian number';
                    //     }
                    //
                    //     return null;
                    //   },
                    //   obscureText: false,
                    //   enableSuggestions: false,
                    //   autocorrect: false,
                    // ),
                    //      PhoneNumberInput(
                    //       initialCountry: 'TZ',
                    //       controller: phoneNumber,
                    //       allowPickFromContacts: false,
                    //       includedCountries: includedCountries,
                    //       countryListMode: CountryListMode.dialog,
                    //       searchHint: "Tan",
                    //       errorText: 'Please check you number',
                    //     ),

                    // InternationalPhoneNumberInput(
                    //   onInputChanged: (PhoneNumber number) {
                    //     print(number);
                    //     if (number.phoneNumber!.length >= 13) {
                    //       setState(() {
                    //         print("+++++++++++++++++++++++++++${number.phoneNumber!}");
                    //         numberOfuser = number.phoneNumber!;
                    //       });
                    //     } else {}
                    //   },
                    //   onInputValidated: (bool value) {
                    //     print(value);
                    //   },
                    //   // selectorConfig: const SelectorConfig(
                    //   //   selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    //   // ),
                    //   ignoreBlank: false,
                    //   autoValidateMode: AutovalidateMode.disabled,
                    //   selectorTextStyle: TextStyle(color: Colors.black),
                    //   initialValue: number,
                    //   countries: ['TZ'],
                    //   maxLength: 9,
                    //   hintText: '743625473',
                    //   textFieldController: phoneNumber,
                    //   formatInput: true,
                    //   keyboardType: const TextInputType.numberWithOptions(
                    //       signed: true, decimal: true),
                    //   // inputBorder: const OutlineInputBorder(),
                    //   onSaved: (PhoneNumber number) {
                    //     print('On Saved: $number');
                    //     // setState(() {
                    //     //   numberOfuser = number.phoneNumber!;
                    //     //   print("---------============" + numberOfuser);
                    //     // });
                    //     print("---------=========s===@@@@@@@@@@@@@@@@@@@@@@" +
                    //         numberOfuser);
                    //   },
                    // ),

                    // Form(
                    //   key: _formKey1,
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.phone,
                    //     controller: phoneNumber ,
                    //     inputFormatters: [
                    //       FilteringTextInputFormatter.digitsOnly,
                    //       LengthLimitingTextInputFormatter(12),
                    //     ],
                    //     decoration: InputDecoration(
                    //       labelText: 'Phone Number',
                    //       hintText: 'Enter a Tanzanian phone number',
                    //       filled: true,
                    //       fillColor: Colors.grey[200],
                    //       contentPadding: const EdgeInsets.all(20.0),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide:
                    //         const BorderSide(color: Colors.transparent),
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide:
                    //         const BorderSide(color: Colors.transparent),
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //       focusedErrorBorder: OutlineInputBorder(
                    //         borderSide: const BorderSide(
                    //             color: Color.fromARGB(0, 36, 10, 10)),
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //       errorBorder: OutlineInputBorder(
                    //         borderSide:
                    //         const BorderSide(color: Colors.transparent),
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //     ),
                    //     validator: (value) {
                    //       final tanzanianRegex = RegExp(r'^255\d{9}$');
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please enter a phone number';
                    //       }else if(!tanzanianRegex.hasMatch(value)){
                    //         if (value.length>3&&value.length < 12 &&!tanzanianRegex.hasMatch(value)) {
                    //           return 'Phone number too short';
                    //         }
                    //         return 'Please enter a valid Tanzanian phone number 255';
                    //       }
                    //
                    //       return null;
                    //     },
                    //   ),
                    // ),

                    Form(
                      key: _formKey1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                        ],
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          hintText: "Enter phone number",
                          border: InputBorder.none,
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
                        validator: (value) {
                          final tanzanianRegex = RegExp(r'^255\d{9}$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          } else if (!tanzanianRegex.hasMatch(value)) {
                            if (value.length > 3 &&
                                value.length < 12 &&
                                !tanzanianRegex.hasMatch(value)) {
                              return 'Phone number too short';
                            }
                            return 'Please enter a valid Tanzanian phone number 255';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _phoneNumber = value!;
                        },
                        onFieldSubmitted: (value) {
                          _phoneNumber = value;
                        },
                        maxLines: 1,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                    ),
                    // CustomTextField(
                    //   controller: controllerPassword,
                    //   hintText: "Enter Password",
                    //   val: !passwordVisibility,
                    //   labelText: 'Password',
                    //   icon: IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           if (passwordVisibility == false) {
                    //             passwordVisibility = true;
                    //           } else {
                    //             passwordVisibility = false;
                    //           }
                    //         });
                    //       },
                    //       icon: Icon(passwordVisibility
                    //           ? Icons.visibility
                    //           : Icons.visibility_off)),
                    // ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: "Enter password",
                          border: InputBorder.none,
                          suffixIcon: IconButton(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (!passwordRegex.hasMatch(value)) {
                            return 'Password must be characters';
                          }
                          return null;
                        },
                        maxLines: 1,
                        obscureText: !passwordVisibility,
                        enableSuggestions: false,
                        autocorrect: false,
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
                    SizedBox(height: deviceSize.height * 0.009),
                    // Padding(
                    //   padding:  EdgeInsets.only(left: deviceSize.width*0.5),
                    //   child: const Text("Forgot Password?",style: TextStyle(color: GlobalVariables.callToAction,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold),),
                    // ),
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
                    Row(
                      children: [
                        Text(
                          "By signing up you agree to our",
                          style:
                              GlobalVariables.myTheme2.textTheme.displaySmall,
                        ),
                        Text(
                          " Terms & ",
                          style:
                              GlobalVariables.myTheme2.textTheme.displayMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Condition ",
                          style:
                              GlobalVariables.myTheme2.textTheme.displayMedium,
                        ),
                        Text(
                          "and ",
                          style:
                              GlobalVariables.myTheme2.textTheme.displaySmall,
                        ),
                        Text(
                          "Privacy Policy.",
                          style:
                              GlobalVariables.myTheme2.textTheme.displayMedium,
                        ),
                        const Text(
                          "*",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ],
                    ),
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
                        if (_formKey1.currentState!.validate()) {
                          // Do something with the phone number
                          _formKey1.currentState!.save();
                          print('Phone number: $_phoneNumber');
                        }
                        final bool isConnected =
                            await InternetConnectionChecker().hasConnection;
                        if (isConnected) {
                          if (_phoneNumber.length >= 12) {
                            setState(() {
                              isLoading = true;
                            });
                            String url =
                                "https://kikundidevbackend.azurewebsites.net/api/user/create";
                            final Map<String, String> headers = {
                              "Content-Type": "application/json"
                            };
                            // final frPhone0 = PhoneNumber.parse(phoneNumber.text);
                            final Map<String, String> body = {
                              "firstName": fullNameController.text,
                              "email": email.text,
                              "phone": _phoneNumber,
                              "password": controllerPassword.text
                            };
                            final String jsonBody = json.encode(body);
                            try {
                              final http.Response response = await http.post(
                                  Uri.parse(url),
                                  headers: headers,
                                  body: jsonBody);
                              setState(() {
                                isLoading = false;
                              });
                              print(response.body);
                              if (response.statusCode == 200) {
                                final Map<String, dynamic> data =
                                    json.decode(response.body);
                                showSnackBarForSuccess(
                                    context, data['successMessage']);
                                // showSnackBarForSuccess(
                                //     context, data['responseObject']['email']);
                                Get.off(OtpVerificationScreen(
                                    email: data['responseObject']['email']));
                              } else {
                                final Map<String, dynamic> data =
                                    json.decode(response.body);
                                print(data);
                                if (data['errors'].toString().length > 30) {
                                  print(data['errors']);
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(context,
                                      "please enter an email in the given field");
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(context, data['errors']);
                                }
                              }
                            } catch (e) {
                              print(e);
                              // Get.off(OtpVerificationScreen(email: email.text));
                            }
                            //
                            // // validation
                          } else {
                            // ignore: use_build_context_synchronously
                            showSnackBarForError1(context, "No internet");
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          showSnackBarForError1(context, "Wrong Tanzanian Number length");
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
                                  "Continue",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.white),
                                ),
                        ],
                      ),
                      width: deviceSize.width * 0.9,
                      height: 50,
                      buttonColor: GlobalVariables.blackColor,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already signed up ?",
                          style:
                              GlobalVariables.myTheme2.textTheme.displaySmall,
                        ),
                        GestureDetector(
                          child: Text(
                            " Login  ",
                            style: GlobalVariables.myTheme2.textTheme.bodyLarge,
                          ),
                          onTap: () {
                            Get.off(const MyHomePage());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    ));
  }
}
