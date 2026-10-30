import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/pages/homepage.dart';

const themekey = 'isDarkMode';
Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = SharedPreferencesAsync();
  final isDarkMode = await prefs.getBool(themekey) ?? false;

  runApp(ExpensesApp(prefs: prefs, initialDarkmode: isDarkMode));
}


class ExpensesApp extends StatefulWidget {
  const new({
    super.key,
    required this.prefs,
    required this.initialDarkmode
  });

  final SharedPreferencesAsync prefs;
  final bool initialDarkmode;
  
  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  late bool _isDarkMode = widget.initialDarkmode;

  Future<void> _setDarkMode(bool value) async{
    setState(() {
      _isDarkMode = value;
    });
    await widget.prefs.setBool(themekey, value);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Notes (Expenses App)',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.dark, 
      ),
      
      home: Homepage(isDarkMode: _isDarkMode, onThemeChanged: _setDarkMode,),
    );
  }
}