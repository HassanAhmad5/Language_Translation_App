import 'package:all_language_translator/view/phrases/phrases_display_view.dart';
import 'package:all_language_translator/widget/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/speak_translate/language_select_cont.dart';
import '../speak_translate/language_select_view.dart';

class PhrasesView extends StatelessWidget {
  PhrasesView({super.key});

  final LanguageSelectController languageController = Get.put(LanguageSelectController());

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> sections = [
      {'title': 'Greetings', 'icon': Icons.sentiment_satisfied_alt, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
      {'title': 'General Conversation', 'icon': Icons.chat, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
      {'title': 'Numbers', 'icon': Icons.calculate, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
      {'title': 'Time and Date', 'icon': Icons.access_time, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
      {'title': 'Direction & Places', 'icon': Icons.place, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
      {'title': 'Transportation', 'icon': Icons.directions_bus, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
      {'title': 'Accommodation', 'icon': Icons.hotel, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
      {'title': 'Eating Out', 'icon': Icons.restaurant, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
      {'title': 'Shopping', 'icon': Icons.shopping_cart, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
      {'title': 'Colours', 'icon': Icons.palette, 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => PhrasesDisplayView()));}},
    ];

    return Scaffold(
      appBar: const Appbar(text: 'Phrases Category'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sections.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: sections[index]['function'],
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            sections[index]['icon'],
                            size: 32,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            sections[index]['title'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
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