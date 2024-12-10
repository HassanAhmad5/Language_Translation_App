import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BaseFunctions {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text, String languageCode) async {
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setSpeechRate(0.5); // Adjust the speed of speech
    await flutterTts.speak(text);
  }

  void copyToClipboardWithFeedback(BuildContext context, String text) {
    if(text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Text Found")),
      );
    }
    else {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Copied to clipboard!")),
      );
    }
  }
}