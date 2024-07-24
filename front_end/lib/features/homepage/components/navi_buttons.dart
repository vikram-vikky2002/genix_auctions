import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontFamily: "Outfit", fontSize: 14),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded),
        ],
      ),
    );
  }
}
