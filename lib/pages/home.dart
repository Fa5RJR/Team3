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
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
          ),
          child: Column(
            children: [
              // Header Section with improved spacing
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.04,
                ),
                child: Column(
                  children: [
                    // Welcome text with better typography
                    Text(
                      'Welcome to'.tr(),
                      style: TextStyle(
                        fontSize: screenWidth * 0.065,
                        color: const Color(0xFF0A2152),
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    
                    // Brand name with enhanced styling
                    Text(
                      'Sanad'.tr(),
                      style: TextStyle(
                        fontSize: screenWidth * 0.14,
                        color: const Color(0xFF0A2152),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        height: 1.1,
                      ),
                    ),
                    
                    SizedBox(height: screenHeight * 0.01),
                    
                    // Tagline
                    Text(
                      'Where ability begins again'.tr(),
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.teal,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Logo section with enhanced container
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/sanad logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: screenHeight * 0.04),
              
              // Action buttons with improved design
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                child: Column(
                  children: [
                    // Sign In Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, "/signin"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Sign in".tr(),
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: screenHeight * 0.02),
                    
                    // Sign Up Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.teal, width: 2),
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, "/signup"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.teal,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Sign up".tr(),
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: screenHeight * 0.04),
              
              // Social media section with improved design
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  children: [
                    Text(
                      'Connect with us',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialButton(
                          icon: Icons.facebook,
                          onPressed: () => _launchURL(facebookUrl),
                          screenWidth: screenWidth,
                        ),
                        _buildSocialButton(
                          icon: FontAwesomeIcons.instagram,
                          onPressed: () => _launchURL(instagramUrl),
                          screenWidth: screenWidth,
                        ),
                        _buildSocialButton(
                          icon: Icons.language,
                          onPressed: () => _launchURL(websiteUrl),
                          screenWidth: screenWidth,
                        ),
                        _buildSocialButton(
                          icon: FontAwesomeIcons.linkedin,
                          onPressed: () => _launchURL(linkedinUrl),
                          screenWidth: screenWidth,
                        ),
                        _buildSocialButton(
                          icon: Icons.phone,
                          onPressed: () => _launchURL(phoneUrl),
                          screenWidth: screenWidth,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: screenHeight * 0.02),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
    required double screenWidth,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: const Color(0xFF0A2152),
          size: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
