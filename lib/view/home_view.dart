import 'package:all_language_translator/view/speak_translate/speak_translate_view.dart';
import 'package:flutter/material.dart';
import '../widget/reuseable_widgets.dart';// Replace with the actual import for HomeWidget

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // List of icons and texts for the grid
    final List<Map<String, dynamic>> homeItems = [
      {'icon': Icons.g_translate, 'text': 'Speak & Translate', 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => SpeakTranslateView()));}},
      {'icon': Icons.translate_rounded, 'text': 'Speech to Text', 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => SpeakTranslateView()));}},
      {'icon': Icons.transcribe, 'text': 'Text to Speech', 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => SpeakTranslateView()));}},
      {'icon': Icons.qr_code_scanner, 'text': 'OCR', 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => SpeakTranslateView()));}},
      {'icon': Icons.message, 'text': 'Phrases', 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => SpeakTranslateView()));}},
      {'icon': Icons.star, 'text': 'Favorite', 'function': () {Navigator.push(context, MaterialPageRoute(builder: (context) => SpeakTranslateView()));}},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(Icons.menu, color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.settings_suggest_sharp, size: 30, color: Colors.white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: homeItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1, // Aspect ratio for each grid item
          ),
          itemBuilder: (context, index) {
            final item = homeItems[index];
            return HomeWidget(
              icon: item['icon'], // Icon for the grid item
              text: item['text'],
              function: item['function'],// Text for the grid item
            );
          },
        ),
      ),
    );
  }
}
