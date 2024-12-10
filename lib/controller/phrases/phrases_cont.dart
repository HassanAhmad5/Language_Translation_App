import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../speak_translate/language_select_cont.dart';


class PhraseController extends GetxController {

  final LanguageSelectController controller = Get.put(LanguageSelectController());

  RxString translatedText = ''.obs;

  // Translator instance
  final GoogleTranslator translator = GoogleTranslator();

  RxList<Map<String, String>> translatedPhrase = <Map<String, String>>[].obs;


  // Translate text from the left language to the right language
  Future<String> translateTextFunction(String text) async {
    if (text.isEmpty) {
      return 'Please enter text to translate.';
    }

    String fromLangCode = getLanguageCode(controller.leftLanguage.value);
    String toLangCode = getLanguageCode(controller.rightLanguage.value);

    try {
      final translation = await translator.translate(
        text,
        from: fromLangCode,
        to: toLangCode,
      );
      return translation.text;
    } catch (e) {
      return 'Failed to translate: $e';
    }
  }




  String getLanguageCode(String language) {
    return controller.languages
        .firstWhere((lang) => lang['language'] == language)['languageCode']!;
  }

}