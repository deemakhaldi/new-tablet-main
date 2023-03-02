import 'dart:developer';
import 'package:get/get.dart';
import 'package:new_tablet/services/localization_service.dart';

class TextTranslations extends Translations {
  late Map<String, Map<String, String>> map;

  @override
  Map<String, Map<String, String>> get keys => map;
}

class TranslationApi {
  getTranslationListMock() {
    return {
      'en': {
        'profile': 'Profile',
        'hello': 'Hello',
        'home': 'Home',
        'contact': 'deema',
        'managersApp': 'Managers App',
        'more': 'More',
        'noNotifications': 'No notifications available!',
        'chooseContact': 'Choose Contact'
      },
      'ar': {
        'profile': 'ملف شخصي',
        'hello': 'مرحبا',
        'home': 'الرئيسية',
        'managersApp': 'دليل المسؤول',
        'more': 'المزيد',
        'noNotifications': 'لا توجد اشعارات!',
        'chooseContact': 'اختر الدليل'
      }
    };
  }

  static Future loadTranslations() async {
    final api = TranslationApi();
    Map<String, Map<String, String>> map = await api.getTranslationListMock();
    Get.find<TextTranslations>().map = map;
  }

  static Future loadApiTranslations(lang) async {
    final res = await LocalizationService.getLocalizationStrings();

    Get.clearTranslations();
    Get.addTranslations({
      lang: {
        ...?Get.find<TextTranslations>().map[lang],
        ...res.cast<String, String>()
      }
    });
  }
}
