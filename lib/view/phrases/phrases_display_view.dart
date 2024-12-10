import 'package:all_language_translator/controller/speak_translate/language_select_cont.dart';
import 'package:all_language_translator/src/models/most_phrases.dart';
import 'package:all_language_translator/src/services/db_service.dart';
import 'package:all_language_translator/widget/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/phrases/phrases_cont.dart';

class PhrasesDisplayView extends StatefulWidget {
  const PhrasesDisplayView({super.key});

  @override
  State<PhrasesDisplayView> createState() => _PhrasesDisplayViewState();
}

class _PhrasesDisplayViewState extends State<PhrasesDisplayView> {

  final LanguageSelectController languageController = Get.put(LanguageSelectController());
  final PhraseController translateController = Get.put(PhraseController());

  final dbService = DatabaseService();

  @override
  void dispose() {
    dbService.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(text: 'Phrases Details'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Placeholder for the main content
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
                future: dbService.getMostPhrasesWithTranslation(translateController.translateTextFunction),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(),);
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      final message = snapshot.data![index]['text'];
                      final userMessage = snapshot.data![index]['translatedText'];
                      final userCountryCode = languageController.getCountryCode(languageController.leftLanguage.value);
                      final translatedCountryCode = languageController.getCountryCode(languageController.rightLanguage.value);

                      return Column(
                        children: [
                          // User message

                          // Translated message
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ChatBubble(
                              text: message.toString(),
                              countryCode: userCountryCode.toString(),
                              isUser: false,
                              languageCode: '',
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ChatBubble(
                              text: userMessage.toString(),
                              countryCode: translatedCountryCode.toString(),
                              isUser: true,
                              languageCode: '${translateController.getLanguageCode(languageController.rightLanguage.value)}-$translatedCountryCode',
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
            )
          ),

        ],
      ),
    );
  }
}







