import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:projeto_final_flutter/pages/home/home_screen.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';
=======
import 'package:projeto_final_flutter/pages/global/colors.dart';
import 'pages/home/home_screen.dart';
>>>>>>> origin/bottonbar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Raleway',
        primaryColor: MyColor.ltPrimaryColor,
        primarySwatch: MyColor.ltPrimaryColor,
        scaffoldBackgroundColor: MyColor.ltBackgroundColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: MyColor.ltAccentColor,
        ),
        cardTheme: const CardTheme(color: MyColor.ltPrimaryColor),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: MyColor.ltPrimaryColor,
          selectedItemColor: MyColor.ltIconsandTextColor,
          unselectedItemColor: MyColor.ltAccentColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.ltAccentColor,
          foregroundColor: Colors.white,
        )),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Raleway',
        primaryColor: MyColor.dtPrimaryColor,
        primarySwatch: MyColor.dtPrimaryColor,
        scaffoldBackgroundColor: MyColor.dtBackgroundColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: MyColor.dtAccentColor,
        ),
        cardTheme: const CardTheme(color: MyColor.dtPrimaryColor),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: MyColor.dtPrimaryColor,
          selectedItemColor: MyColor.dtIconsandTextColor,
          unselectedItemColor: MyColor.dtAccentColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.dtAccentColor,
          foregroundColor: Colors.white,
        )),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
