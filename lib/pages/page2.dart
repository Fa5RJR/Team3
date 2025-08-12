import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'page1.dart';
import 'main.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,


        leadingWidth: screenWidth * 0.18,

        leading: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(40, 40),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.01,
                  vertical: 0,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                final current = context.locale;
                final next = current.languageCode == 'en'
                    ? const Locale('ar')
                    : const Locale('en');
                context.setLocale(next);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.translate, color: Color(0xFF0A2152), size: 20),
                  const SizedBox(width: 4),
                  Text(
                    context.locale.languageCode == 'en' ? 'AR' : 'EN',
                    style: TextStyle(
                      color: const Color(0xFF0A2152),
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              MyApp.themeNotifier.value =
              MyApp.themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
            icon: Icon(
              MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: const Color(0xFF0A2152),
            ),
          ),
        ],
      ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Build a better Future'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Colors.black,
                  height: 1.5,
                  letterSpacing: 1.2,
                ),
              ),
              Image.asset(
                'assets/images/build_edit.jpg',
                width: MediaQuery.of(context).size.width * 0.85,
              ),

              SizedBox(height: 10),


              Text(
                'Where ability begins again'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 28,
                  color: Colors.black,
                  height: 1.5,
                  letterSpacing: 1.2,
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/home"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Get Started'.tr(),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: SizedBox(
          height: 90,
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 110),
            painter: WavePainter(),
        ),
      ),
    );
  }
}