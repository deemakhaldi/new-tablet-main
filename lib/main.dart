import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_tablet/localization/localization.dart';
import 'package:new_tablet/locator.dart';
import 'package:new_tablet/screens/login/login_screen.dart';
import 'package:path_provider/path_provider.dart';

const MaterialColor kPrimaryColor = MaterialColor(
  0xFF790000,
  <int, Color>{
    50: Color.fromRGBO(121, 0, 0, 0.1),
    100: Color.fromRGBO(121, 0, 0, 0.2),
    200: Color.fromRGBO(121, 0, 0, 0.3),
    300: Color.fromRGBO(121, 0, 0, 0.4),
    400: Color.fromRGBO(121, 0, 0, 0.5),
    500: Color.fromRGBO(121, 0, 0, 0.6),
    600: Color.fromRGBO(121, 0, 0, 0.7),
    700: Color.fromRGBO(121, 0, 0, 0.8),
    800: Color.fromRGBO(121, 0, 0, 0.9),
    900: Color.fromRGBO(121, 0, 0, 1),
  },
);
late Directory appDocsDir;

void main() async {
  setup();
  Get.put(TextTranslations());
  await TranslationApi.loadTranslations();
  WidgetsFlutterBinding.ensureInitialized();

  appDocsDir = await getApplicationDocumentsDirectory();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: 'home',
      // onGenerateRoute: RouteGenerator.generateChildrenRoutes,
      locale: Locale('en'),
      translationsKeys: Get.find<TextTranslations>().keys,
      translations: Get.find<TextTranslations>(),

      title: 'Managers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tajawal',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: kPrimaryColor,
        ),
        brightness: Brightness.light,
        errorColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
        primaryColor: const Color.fromARGB(255, 121, 0, 0),
        accentColor: const Color.fromARGB(255, 192, 22, 28),
      ),
      home: LoginScreen(),
    );
  }
}
