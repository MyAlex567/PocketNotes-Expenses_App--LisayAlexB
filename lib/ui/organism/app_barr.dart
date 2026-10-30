import 'package:flutter/material.dart';
import '../molecules/theme_toggle.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomeAppBar({
    super.key,
    required this.text,
    required this.isDarkMode,
    required this.onThemeChanged,
  });



  // Scaffold.appBar needs a preferred size. This is the same height a plain
  // AppBar reports when it has no `bottom` and no custom toolbarHeight.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      actions: [
        ThemeToggle(isDarkMode: isDarkMode, onChanged: onThemeChanged),
        const SizedBox(width: 8),
      ],
    );
  }
}
