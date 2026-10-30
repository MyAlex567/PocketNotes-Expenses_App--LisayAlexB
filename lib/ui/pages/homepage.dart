import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses App"),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
              Switch(
                value: widget.isDarkMode, 
                onChanged: widget.onThemeChanged
              )
            ],
          ),
        ],
      ),
    );
  }
}