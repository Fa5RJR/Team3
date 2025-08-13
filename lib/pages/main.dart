import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbs/pages/Aboutus.dart';
import 'package:sbs/pages/feedback.dart';
import 'home.dart';
import 'signup.dart';
import 'signin.dart';
import 'page1.dart';
import 'home_screen.dart';
import 'SettingsPage.dart';
import 'feedback.dart';
import 'Aboutus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;


  MyApp.themeNotifier.value =
  isDarkMode ? ThemeMode.dark : ThemeMode.light;

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/tr',
      fallbackLocale: Locale('en'),
      saveLocale: true,


      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,

          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Color(0xFF0A2152)),
            ),
            iconTheme: const IconThemeData(color: Color(0xFF0A2152)),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),

          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: '/',
          routes: {
          '/':       (context) =>  SplashScreen(),
          '/home': (context) => const HomePage(),
          '/signup': (context) => const Signup(),
            '/signin': (context) => const LoginScreen(),
            // buttom bar
            '/Sign in': (context) =>  HomeScreen(),
            '/settings': (context) => Setting(),
           // '/feedback': (context) => FeedbackPage(),
            '/aboutus' : (context) => about(),

          },
        );
      },
    );
  }
}
////'/home' LLLLOOOOOOGGGG OOUUUTT
