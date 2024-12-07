import 'package:all_language_translator/controller/speak_translate/language_select_cont.dart';
import 'package:all_language_translator/controller/speak_translate/speak_translate_cont.dart';
import 'package:all_language_translator/view/speak_translate/language_select_view.dart';
import 'package:all_language_translator/widget/reuseable_widgets.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpeakTranslateView extends StatefulWidget {
  const SpeakTranslateView({super.key});

  @override
  State<SpeakTranslateView> createState() => _SpeakTranslateViewState();
}

class _SpeakTranslateViewState extends State<SpeakTranslateView> {

  final LanguageSelectController languageController = Get.put(LanguageSelectController());
  final SpeakTranslateController translateController = Get.put(SpeakTranslateController());

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(text: 'Speak & Translate'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Placeholder for the main content
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: translateController.messageHistory.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  final message = translateController.messageHistory[index];
                  final userMessage = message['user']!;
                  final translatedMessage = message['translated']!;
                  final userCountryCode = message['userCountryCode']!;
                  final translatedCountryCode = message['translatedCountryCode']!;

                  return Column(
                    children: [
                      // User message

                      // Translated message
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ChatBubble(
                          text: userMessage,
                          countryCode: userCountryCode,
                          isUser: false,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ChatBubble(
                          text: translatedMessage,
                          countryCode: translatedCountryCode,
                          isUser: true,
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),

          // First Row: Text Input and Send Button
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),

            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter text to translate',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    translateController.translateText(_textController.text, languageController.leftLanguage.value, languageController.rightLanguage.value);
                    _textController.text = '';
                  },
                  child: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 1,
            width: double.infinity,
            color: Colors.black,
          ),

          // Second Row: Speak Button and Language Selector
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Section 1: Mic Button and Language
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LanguageSelectView(isLeft: true),
                            ),
                          );
                        },
                        child: Text(
                          languageController.leftLanguage.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        String selectedLanguage = translateController.getLanguageCode(languageController.leftLanguage.value);
                        showListeningDialog(context, languageController.leftLanguage.value);

                        translateController.startListening(selectedLanguage, languageController.leftLanguage.value, languageController.rightLanguage.value).then((_) {
                          Navigator.of(context).pop(); // Close the dialog once listening is done
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.mic,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
                    ),

                  ],
                ),

                IconButton(
                  onPressed: () {
                    languageController.swapLanguages();
                  },
                  icon: const Icon(
                    Icons.swap_horiz,
                    color: Colors.black,
                    size: 30,
                  ),
                ),

                // Section 2: Mic Button and Language
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LanguageSelectView(isLeft: false),
                            ),
                          );
                        },
                        child: Text(
                          languageController.rightLanguage.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        String selectedLanguage = translateController.getLanguageCode(languageController.rightLanguage.value);
                        showListeningDialog(context, languageController.rightLanguage.value);

                        translateController.startListening(selectedLanguage, languageController.rightLanguage.value, languageController.leftLanguage.value).then((_) {
                          Navigator.of(context).pop(); // Close the dialog once listening is done
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.mic,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final String countryCode;
  final bool isUser;

  const ChatBubble({required this.text, required this.isUser, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: !isUser ? Colors.white : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(8.0),
          topRight: const Radius.circular(8.0),
          bottomLeft: Radius.circular(isUser ? 8.0 : 0.0),
          bottomRight: Radius.circular(isUser ? 0.0 : 8.0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isUser)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flag.fromString(
                  countryCode,
                  height: 25,
                  width: 25,
                ),
                const SizedBox(width: 10),
                // Wrap text with ConstrainedBox to limit its width
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7), // 70% of screen width
                  child: Text(
                    text,
                    style: TextStyle(
                      color: !isUser ? Colors.black : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          if (isUser)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flag.fromString(
                      countryCode,
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 10),
                    // Wrap text with ConstrainedBox to limit its width
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: !isUser ? Colors.black : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {}, // Add play audio functionality
                      icon: const Icon(Icons.volume_up, color: Colors.white),
                      iconSize: 20,
                    ),
                    IconButton(
                      onPressed: () {}, // Add favorite functionality
                      icon: const Icon(Icons.star_border, color: Colors.white),
                      iconSize: 20,
                    ),
                    IconButton(
                      onPressed: () {}, // Add copy text functionality
                      icon: const Icon(Icons.copy, color: Colors.white),
                      iconSize: 20,
                    ),
                    IconButton(
                      onPressed: () {}, // Add share functionality
                      icon: const Icon(Icons.share, color: Colors.white),
                      iconSize: 20,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

void showListeningDialog(BuildContext context, String language) {

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Listening to $language...",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mic,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Listening...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}





