import 'package:flutter/material.dart';
import 'package:home_crm/data/database/db.dart';
import 'package:home_crm/utils/app_themes.dart';
import 'package:home_crm/utils/di.dart';
import 'package:home_crm/views/splash.dart';
import 'package:stacked_themes/stacked_themes.dart';

void main(List<String> args) async{
   setupLocator();
  await ThemeManager.initialise();
   await SQLHelper.db();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {


   
  return ThemeBuilder(
     defaultThemeMode: ThemeMode.light,
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      backgroundColor: Colors.blue[700],
      accentColor: Colors.yellow[700],
    ),
    lightTheme: ThemeData(
      brightness: Brightness.light,
      backgroundColor: Colors.blue[300],
      accentColor: Colors.yellow[300],
    ),
      builder: (context, regularTheme, darkTheme, themeMode) =>
      
       MaterialApp(
        title: 'Home CRM',
        debugShowCheckedModeBanner: false,
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: SplashScreen(),
      ),

    );
  }
}