import 'package:flutter/material.dart';

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



