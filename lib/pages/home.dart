import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String facebookUrl  = 'https://www.facebook.com/profile.php?id=61578979035430';
  final String websiteUrl   = '';
  final String phoneUrl     = 'tel:+201126588499';
  final String instagramUrl = 'https://www.instagram.com/sanad_20253?igsh=MXRlejNiY2VuNDZtOA==';
  final String linkedinUrl  = '';

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.03),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                SizedBox(height: screenHeight * 0.03),

                Text(
                  'Welcome to'.tr(),
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    color: const Color(0xFF0A2152),
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: screenHeight * 0.003),

                Text(
                  'Sanad'.tr(),
                  style: TextStyle(
                    fontSize: screenWidth * 0.15,
                    color: const Color(0xFF0A2152),
                    fontWeight: FontWeight.bold,
                  ),
                ),



                //SizedBox(height: screenHeight * 0.015),


                Image.asset(
                  'assets/images/sanad logo.jpg',
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),



                SizedBox(height: screenHeight * 0.02),

               // Text(
                 // 'Where ability begins again'.tr(),
                  //style: TextStyle(
                    //fontSize: screenWidth * 0.06,
                    //color: Colors.grey[900],
                    //fontWeight: FontWeight.w400,
                  //),
                //),

                const Spacer(flex: 3),

                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/signin"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    elevation: 9,
                    shadowColor: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.30,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.06),
                    ),
                  ),
                  child: Text(
                    "Sign in".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/signup"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    elevation: 9,
                    shadowColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.30,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.06),
                    ),
                  ),
                  child: Text(
                    "Sign up".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Spacer(flex: 3),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.facebook, color: const Color(0xFF0A2152), size: screenWidth * 0.13),
                      onPressed: () => _launchURL(facebookUrl),
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.instagram, color: const Color(0xFF0A2152), size: screenWidth * 0.13),
                      onPressed: () => _launchURL(instagramUrl),
                    ),
                    IconButton(
                      icon: Icon(Icons.language, color: const Color(0xFF0A2152), size: screenWidth * 0.13),
                      onPressed: () => _launchURL(websiteUrl),
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.linkedin, color: const Color(0xFF0A2152), size: screenWidth * 0.13),
                      onPressed: () => _launchURL(linkedinUrl),
                    ),
                    IconButton(
                      icon: Icon(Icons.phone, color: const Color(0xFF0A2152), size: screenWidth * 0.13),
                      onPressed: () => _launchURL(phoneUrl),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
