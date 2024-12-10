import 'package:all_language_translator/controller/base_functions.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/speak_translate/speak_translate_cont.dart';

class HomeWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback function;

  const HomeWidget({super.key, required this.icon, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white, // Light grey background
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Subtle shadow
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Red circle with the icon
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                color: Colors.red, // Red circle
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white, // White icon inside the circle
                size: 35,
              ),
            ),
            const SizedBox(height: 8), // Spacing between circle and text
            // Text below the circle
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const Appbar({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ChatBubble extends StatelessWidget {
  final String text;
  final String countryCode;
  final String languageCode;
  final bool isUser;

  ChatBubble({required this.text, required this.isUser, required this.countryCode, required this.languageCode});

  final SpeakTranslateController translateController = Get.put(SpeakTranslateController());
  final BaseFunctions baseFunctions = BaseFunctions();

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
                      onPressed: () {
                        baseFunctions.speak(text, languageCode);
                      }, // Add play audio functionality
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



