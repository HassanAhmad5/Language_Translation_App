import 'package:all_language_translator/controller/speak_translate/language_select_cont.dart';
import 'package:all_language_translator/widget/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:get/get.dart';

class LanguageSelectView extends StatelessWidget {
  final bool isLeft;

  LanguageSelectView({super.key, required this.isLeft});

  final LanguageSelectController controller = Get.put(LanguageSelectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(text: 'Select Language'),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.filterLanguages(value),
              decoration: InputDecoration(
                hintText: 'Search language...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // Language list
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.filteredLanguages.length,
                itemBuilder: (context, index) {
                  final language = controller.filteredLanguages[index]['language']!;
                  final countryCode = controller.filteredLanguages[index]['countryCode']!;

                  final bool isSelected = isLeft
                      ? language == controller.leftLanguage.value
                      : language == controller.rightLanguage.value;

                  return ListTile(
                    leading: Flag.fromString(
                      countryCode,
                      height: 30,
                      width: 30,
                    ),
                    title: Text(
                      language,
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    onTap: () {
                      if (isLeft) {
                        controller.updateLeftLanguage(language);
                      } else {
                        controller.updateRightLanguage(language);
                      }
                      Navigator.pop(context); // Close the screen
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
