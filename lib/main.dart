import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homescreen/home_screen.dart';
import 'package:projeto_final_flutter/features/home/homelogin/homelogin.dart';
import 'package:projeto_final_flutter/features/home/splashpage/splashpage.dart';
import 'package:projeto_final_flutter/features/transactions/despesas/despesas_page.dart';
import 'package:projeto_final_flutter/features/transactions/receitas/receitas_page.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';
import 'features/transactions/metas/metas_page.dart';
import 'features/wallets/bank_account/add_bank_account_page.dart';
import 'features/home/homesignup/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/wallets/card/add_card_page.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'shared/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(),
      routes: {
        '/signup': (context) => const HomeSignup(),
        '/login': (context) => const HomeLogin(),
        '/screen': (context) => const HomeScreen(),
        '/splash': (context) => const SplashPage(),
        '/addBankAccount': (context) => const AddBankAccount(),
        '/addCard': (context) => const AddCard(),
        '/addDespesa': (context) => const DespesasPage(),
        '/addReceita': (context) => const ReceitasPage(),
        '/metas': (context) => const MetasPage(),
      },
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black))),
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
