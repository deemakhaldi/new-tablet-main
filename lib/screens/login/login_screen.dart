import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:new_tablet/localization/localization.dart';
import 'package:new_tablet/main.dart';
import 'package:new_tablet/models/contact_model.dart';
import 'package:new_tablet/models/item_model.dart';
import 'package:new_tablet/models/user_configs_model.dart';
import 'package:new_tablet/screens/home/home_screen.dart';
import 'package:new_tablet/services/api_service.dart';
import 'package:new_tablet/models/login_model.dart';
import 'package:new_tablet/services/contacts_service.dart';
import 'package:new_tablet/services/database_service.dart';
import 'package:new_tablet/services/items_service.dart';
import 'package:new_tablet/services/login_service.dart';
import 'package:new_tablet/utils/utils.dart';
import 'package:new_tablet/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:new_tablet/services/shared_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isApiCallProcess = false;

  final _formKey = GlobalKey<FormState>();
  String _account = 'develtest5_2';
  String _username = 'deema2';
  String _password = '100100a';

  var errorMsg = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  callbackUser(val) {
    setState(() {
      _username = val;
    });
  }

  callbackAcc(val) {
    setState(() {
      _account = val;
    });
  }

  callbackPass(val) {
    setState(() {
      _password = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.8;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.7,
                      height: height * 0.45,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 238, 238, 238)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CustomTextField(callbackAcc,
                        controller: _account,
                        icon: Icons.email,
                        errorText: "Account is required",
                        hint: "Account",
                        isPassword: false),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextField(callbackUser,
                        controller: _username,
                        icon: Icons.person,
                        errorText: "Username is required",
                        hint: "Username",
                        isPassword: false),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextField(
                      callbackPass,
                      controller: _password,
                      icon: Icons.lock,
                      errorText: "Password is required",
                      hint: "Password",
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 238, 238, 238)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 238, 238, 238))))),
                              child: isApiCallProcess
                                  ? SizedBox(
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                      height: 30.0,
                                      width: 30.0,
                                    )
                                  : new Text(
                                      "Login",
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                              onPressed: () async {
                                print('hooooooooooon');

                                // var status = await Permission.bluetooth.status;
                                // if (status.isDenied) {
                                //   await Permission.bluetooth.request();
                                // }

                                // if (await Permission
                                //     .bluetooth.status.isPermanentlyDenied) {
                                //   openAppSettings();
                                // }

                                // ZebraPrinter zebraPrinter =
                                //     await Zebrautility.getPrinterInstance(
                                //         onPrinterFound: onPrinterFound(
                                //             'deema', '48A493A5726F', false),
                                //         onPrinterDiscoveryDone:
                                //             onPrinterDiscoveryDone,
                                //         onChangePrinterStatus:
                                //             onChangePrinterStatus,
                                //         onPermissionDenied: onPermissionDenied);

                                // print(zebraPrinter);

                                // zebraPrinter.discoveryPrinters();

                                // zebraPrinter.connectToPrinter("48A493A5726F");
                                APIService apiService = new APIService();
                                LoginService loginService = new LoginService();
                                final form = _formKey.currentState;
                                form!.save();

                                // Validate will return true if is valid, or false if invalid.
                                if (form.validate()) {
                                  print('valiiiiiiiiid');
                                  setState(() {
                                    isApiCallProcess = true;
                                  });

                                  final ConnectivityResult result =
                                      await Connectivity().checkConnectivity();

                                  print('result->$result');

                                  if (result == ConnectivityResult.none) {
                                    print('OFFLINE');

                                    // UserConfigsModel? user =
                                    //     await loginService.getUserData();

                                    // DatabaseHelper dbHelper =
                                    //     new DatabaseHelper();

                                    // UserConfigsModel? user =
                                    //     await dbHelper.getTableData();
                                    // print(user!.username);

                                    utils.account = _account.trim();
                                    utils.username = _username.trim();

                                    print('yalaaaaaaaaaaaaaaaa');
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                        ModalRoute.withName('/dashboard'));
                                  } else {
                                    loginService
                                        .login(_account.trim(),
                                            _username.trim(), _password.trim())
                                        .then((value) async {
                                      if (value != null) {
                                        if (value.token!.isNotEmpty) {
                                          await getAndSaveData();
                                          setState(() {
                                            isApiCallProcess = false;
                                          });
                                          Map<String, dynamic> res =
                                              await apiService
                                                  .get('tablet-init');
                                          Get.updateLocale(Locale(res['lang']));
                                          Get.put(TextTranslations());
                                          await TranslationApi
                                              .loadApiTranslations(res['lang']);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(),
                                              ),
                                              ModalRoute.withName(
                                                  '/dashboard'));
                                        }
                                      }
                                    }).catchError((err) => {
                                              print(err),
                                              setState(() {
                                                isApiCallProcess = false;
                                                errorMsg = err;
                                              })
                                            });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getAndSaveData() async {
    SharedService.configs = await SharedService().getList<dynamic>();
    await ItemsService().getList<ItemModel>();
    await ContactsService().getList<Contact>();
     a,
    
  }
}

Function onPrinterFound = (name, ipAddress, isWifiPrinter) {
  print("PrinterFound :" + name + ipAddress + isWifiPrinter.toString());
};

Function onPrinterDiscoveryDone = () {
  print("Discovery Done");
};

Function onChangePrinterStatus = (status, color) {
  print("change printer status: " + status + color);
};

Function onPermissionDenied = () {
  print("Permission Deny.");
};
