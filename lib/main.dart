  import 'package:flutter/material.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'ui/pages/homepage.dart';

  const themekey = 'isDarkMode';
  Future<void> main() async{

    WidgetsFlutterBinding.ensureInitialized();
    final prefs = SharedPreferencesAsync();

    // Comment this first sir before trying the Experiment 1
    final isDarkMode = await prefs.getBool(themekey) ?? false;

    // and change the initialDarkmode value into false
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

    // this is the added code for experiment 1
    // @override
    // void initState(){
    //   super.initState();
    //   _loadTheme();
    // }

    // Future<void> _loadTheme() async {
    //   await Future.delayed(const Duration(seconds: 2));
    //   final isDarkMode = await widget.prefs.getBool(themekey) ?? false; 
    //   if(!mounted) return;
    //   setState(() {
    //     _isDarkMode = isDarkMode;
    //   });
    // }

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
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: Homepage(isDarkMode: _isDarkMode, onThemeChanged: _setDarkMode,),
      );
    }
  }