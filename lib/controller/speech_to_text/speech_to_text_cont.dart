import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../speak_translate/language_select_cont.dart';


class SpeechToTextController extends GetxController {

  final LanguageSelectController controller = Get.put(LanguageSelectController());

  final TextEditingController textController = TextEditingController();


  void appendUserSpeech(String speech) {
    textController.text = textController.text+speech;
    textController.selection = TextSelection.fromPosition(
      TextPosition(offset: textController.text.length), // Set cursor at the end
    );
  }


  @override
  void onInit() {
    super.onInit();
    // Reset userText whenever the language changes
    ever(controller.leftLanguage, (_) {
      textController.text = ''; // Reset the text when language changes
    });
  }



  String getLanguageCode(String language) {
    return controller.languages
        .firstWhere((lang) => lang['language'] == language)['languageCode']!;
  }

  static const platform = MethodChannel('all_language_translator/speech');

  Future<void> startListening(String languageCode) async {
    try {
      // Call native platform to start listening
      String userSpeech = await platform.invokeMethod('startListening', {'language': languageCode});

      if (userSpeech.isNotEmpty) {
        // Append the speech to userText
        textController.text += ' $userSpeech';


        // Move the cursor to the end of the text
        textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length),
        );
      }
    } on PlatformException catch (e) {
      print("Failed to start listening: ${e.message}");
    }
  }




}