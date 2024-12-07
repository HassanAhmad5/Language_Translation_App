import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import 'language_select_cont.dart';

class SpeakTranslateController extends GetxController {

  final LanguageSelectController controller = Get.put(LanguageSelectController());

  RxString translatedText = ''.obs;

  // Translator instance
  final GoogleTranslator translator = GoogleTranslator();

  RxList<Map<String, String>> messageHistory = <Map<String, String>>[].obs;

  // Translate text from the left language to the right language
  Future<void> translateText(String text, String srcLanguage, String tarLanguage) async {
    if (text.isEmpty) {
      translatedText.value = 'Please enter text to translate.';
      return;
    }

    String fromLangCode = getLanguageCode(srcLanguage);
    String toLangCode = getLanguageCode(tarLanguage);

    try {
      final translation = await translator.translate(
        text,
        from: fromLangCode,
        to: toLangCode,
      );
      translatedText.value = translation.text;
      String? userCountryCode = controller.getCountryCode(srcLanguage);
      String? translatedCountryCode = controller.getCountryCode(tarLanguage);

      messageHistory.add({'user': text, 'userCountryCode': userCountryCode!, 'translated': translatedText.value, 'translatedCountryCode': translatedCountryCode!});

    } catch (e) {
      translatedText.value = 'Failed to translate: $e';
    }
  }

  String getLanguageCode(String language) {
    return controller.languages
        .firstWhere((lang) => lang['language'] == language)['languageCode']!;
  }

  static const platform = MethodChannel('all_language_translator/speech');

  Future<void> startListening(String languageCode, String srcLanguage, String tarLanguage) async {
    try {
      // Call native platform to start listening
      String userSpeech = await platform.invokeMethod('startListening', {'language': languageCode});

      if (userSpeech.isNotEmpty) {
        // Translate the captured speech
        await translateText(userSpeech, srcLanguage, tarLanguage);
      }
    } on PlatformException catch (e) {
      print("Failed to start listening: ${e.message}");
    }
  }

}