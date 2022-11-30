import 'package:flutter/material.dart';
import 'features/login/login_page.dart';
import 'theme/global/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO deletar linha 18 e tirar comentário da 17
      //home: const HomeScreen(),
      home: const LoginPage(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Raleway',
        primaryColor: MyColor.lightThemePrimaryColor,
        primarySwatch: MyColor.lightThemePrimaryColor,
        scaffoldBackgroundColor: MyColor.lightThemeBackgroundColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: MyColor.lightThemeAccentColor,
        ),
        cardTheme: const CardTheme(color: MyColor.lightThemePrimaryColor),
        textButtonTheme: TextButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black))),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: MyColor.lightThemePrimaryColor,
          selectedItemColor: MyColor.lightThemeIconsandTextColor,
          unselectedItemColor: MyColor.lightThemeAccentColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.lightThemeAccentColor,
          foregroundColor: Colors.white,
        )),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Raleway',
        primaryColor: MyColor.darkThemePrimaryColor,
        primarySwatch: MyColor.darkThemePrimaryColor,
        scaffoldBackgroundColor: MyColor.darkThemeBackgroundColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: MyColor.darkThemeAccentColor,
        ),
        cardTheme: const CardTheme(color: MyColor.darkThemePrimaryColor),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: MyColor.darkThemePrimaryColor,
          selectedItemColor: MyColor.darkThemeIconsandTextColor,
          unselectedItemColor: MyColor.darkThemeAccentColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.darkThemeAccentColor,
          foregroundColor: Colors.white,
        )),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
