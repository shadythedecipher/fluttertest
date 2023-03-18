import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttertest/GlobalStyle/GlobalVariables.dart';
import 'package:fluttertest/Widgets/Button.dart';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UtilsFunctions/Utils.dart';
import '../main.dart';

class mainScreen extends StatefulWidget {
  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  late SharedPreferences preferences;
  String? email;
  String? username;
  String? token;
  bool _isLoading = true;
  late Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      preferences = prefs;
      email = preferences.getString('email');
      username = preferences.getString('username');
      token = preferences.getString('token');
      setState(() {
        email = preferences.getString('email');
      });
      Map<String, dynamic> _data;
      String url =
          "https://kikundidevbackend.azurewebsites.net/api/user/group/products/fetchGroupTotalSavings";
      final Map<String, String> headers = {"Content-Type": "application/json"};
      // final frPhone0 = PhoneNumber.parse(phoneNumber.text);
      final Map<String, String> body = {
        "email": preferences.getString('email')!,
        "group_name": "",
        "filter": "all"
      };
      final String jsonBody = json.encode(body);
      try {
        final http.Response response =
            await http.post(Uri.parse(url), headers: headers, body: jsonBody);
        // setState(() {
        //   _isLoading = false;
        // });
        // print(response.body);
        if (response.statusCode == 200) {
          setState(() {
            data = json.decode(response.body);
            _isLoading = false;
          });
          // ignore: use_build_context_synchronously
          showSnackBarForSuccess(context, "Fetched total details");
          // showSnackBarForSuccess(
          //     context, data['responseObject']['email']);
        } else {}
      } catch (e) {
        print(e);
        // Get.off(OtpVerificationScreen(email: email.text));
      }

      // setState(() {
      //   _isLoading = false;
      // });
      setState(() {
        email = preferences.getString('email');
      }); // Update the UI with the retrieved email value
    });
    // _loadData();
  }
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    final random = Random();
    final faker = Faker();
    return SafeArea(
      child: Scaffold(
        drawer:  SafeArea(
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 110,
                    ),
                  ),
                  accountEmail: Text(email!),
                  accountName: Text(
                  username!,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  decoration:  BoxDecoration(
                      color: GlobalVariables.blackColor),
                ),
                ListTile(
                  leading: const Icon(Icons.house),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontFamily:
                      GoogleFonts.lato(fontSize: 29.0).fontFamily,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.inventory_2_outlined),
                  title: Text(
                    'Wallets',
                    style: TextStyle(
                      fontFamily:
                      GoogleFonts.lato(fontSize: 29.0).fontFamily,
                    ),
                  ),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(
                    'My group',
                    style: TextStyle(
                      fontFamily:
                      GoogleFonts.lato(fontSize: 29.0).fontFamily,
                    ),
                  ),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily:
                      GoogleFonts.lato(fontSize: 29.0).fontFamily,
                    ),
                  ),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily:
                      GoogleFonts.lato(fontSize: 29.0).fontFamily,
                    ),
                  ),
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear();
                    print("Available shared preferences" +
                        preferences.toString());
                    Get.to(const MyHomePage());
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            margin: EdgeInsets.only(
              top: deviceSize.height * 0.009,
            ),
            padding: EdgeInsets.only(
                right: deviceSize.width * 0.05, left: deviceSize.width * 0.08),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Hello $username 👋",
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Let’s save your money!",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
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
                Container(
                  height: deviceSize.height * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCB713),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Savings",
                                      style: GoogleFonts.poppins(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    _isLoading
                                        ? const CircularProgressIndicator()
                                        : Text(
                                            "${data['responseObject']['saving']['total']} Tshs",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 50,
                        left: 230,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFD456),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        bottom: 0,
                        left: 160,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            // borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Due Date on ${random.nextInt(31 - 1)}th Jun",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CustomButton(
                                  () {},
                                  widgetChild: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Save more",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  width: deviceSize.width * 0.9,
                                  height: 20,
                                  buttonColor: GlobalVariables.blackColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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
                Container(
                  height: deviceSize.height * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCB713),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Loans",
                                      style: GoogleFonts.poppins(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    _isLoading
                                        ? CircularProgressIndicator()
                                        : Text(
                                            "${data['responseObject']['loans']['total']} Tshs",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 50,
                        left: 230,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFD456),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        bottom: 0,
                        left: 160,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            // borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Due Date on ${random.nextInt(31 - 1)}th Oct",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CustomButton(
                                  () {},
                                  widgetChild: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Save more",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  width: deviceSize.width * 0.9,
                                  height: 20,
                                  buttonColor: GlobalVariables.blackColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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
                Container(
                  height: deviceSize.height * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCB713),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Shares",
                                      style: GoogleFonts.poppins(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    _isLoading
                                        ? const CircularProgressIndicator()
                                        : Text(
                                            "${data['responseObject']['shares']['total']} Tshs",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 50,
                        left: 230,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFD456),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        bottom: 0,
                        left: 160,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            // borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Due Date on ${random.nextInt(31 - 1)}th Aug",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CustomButton(
                                  () {},
                                  widgetChild: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Save more",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  width: deviceSize.width * 0.9,
                                  height: 20,
                                  buttonColor: GlobalVariables.blackColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent payments",
                      style:
                          GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
                SizedBox(
                  height: deviceSize.height * 0.009,
                ),
                SizedBox(
                  height: deviceSize.height * 0.009,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      final name = faker.person.name();

                      final price = random.nextInt(200000 - 100);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(

                            children: [
                              Text(
                                name.capitalizeFirst!
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 23.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                          name.length>10?  name.substring(0,10):name,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 48.0),
                                          child: Text(
                                            '$price tsh',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${faker.company.name().substring(0,7)} bank",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: GlobalVariables.buttonColor,
          unselectedItemColor: Colors.grey,
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'My Group',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
