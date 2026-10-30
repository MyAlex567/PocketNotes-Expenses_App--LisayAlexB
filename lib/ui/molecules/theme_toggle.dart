import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
        Switch(
          value: isDarkMode,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
