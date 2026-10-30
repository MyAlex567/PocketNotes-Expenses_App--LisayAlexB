import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final IconData icon;
  final String text;

  const TextMessage({
    super.key,
    required this.icon,
    required this.text,
  }); 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 12,),
            Text(text, textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}