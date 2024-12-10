import 'package:all_language_translator/controller/base_functions.dart';
import 'package:all_language_translator/controller/speak_translate/language_select_cont.dart';
import 'package:all_language_translator/view/speak_translate/language_select_view.dart';
import 'package:all_language_translator/widget/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/speech_to_text/speech_to_text_cont.dart';
import '../speak_translate/speak_translate_view.dart';

class SpeechToTextView extends StatelessWidget {
  SpeechToTextView({super.key});

  final BaseFunctions baseFunctions = BaseFunctions();


  @override
  Widget build(BuildContext context) {

    final LanguageSelectController languageController = Get.put(LanguageSelectController());
    final SpeechToTextController speechTextController = Get.put(SpeechToTextController());

    return Scaffold(
      appBar: const Appbar(text: 'Speech to Text'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LanguageSelectView(isLeft: true),
                    ),
                  );
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.red[50],
                    hintText: 'Select Language',
                  ),
                  child: Text(
                    languageController.leftLanguage.value.isEmpty
                        ? 'Select Language'
                        : languageController.leftLanguage.value,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: speechTextController.textController,
                maxLines: 4,
                // onChanged: (text) {
                //   // Sync manual edits to `userText`
                //   speechTextController.userText.value = text;
                // },
                decoration: const InputDecoration(
                  hintText: 'Edit Your Text Here....',
                  border: OutlineInputBorder(),
                ),
              )
            ),



            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    print(speechTextController.textController.text);
                    baseFunctions.speak(speechTextController.textController.text, languageController.leftLanguage.value);
                  },
                  icon: const Icon(Icons.volume_up, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {
                    baseFunctions.copyToClipboardWithFeedback(context, speechTextController.textController.text);
                  },
                  icon: const Icon(Icons.copy, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                String selectedLanguage = speechTextController.getLanguageCode(languageController.leftLanguage.value);
                showListeningDialog(context, languageController.leftLanguage.value);

                speechTextController.startListening(selectedLanguage).then((_) {
                  Navigator.of(context).pop(); // Close the dialog once listening is done
                });
              },
              child: const Text('Tap to Speak', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}