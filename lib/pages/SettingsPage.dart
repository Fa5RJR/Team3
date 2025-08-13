import 'package:flutter/material.dart';
import 'main.dart';
import 'Aboutus.dart';

import 'home.dart';


class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:  Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: const Icon(Icons.logout, color: Color(0xFFB00020)),
              label:  Text(
                "Log Out",
                style: TextStyle(fontSize: 18, color: Color(0xFFB00020)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
            ),

            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => about()),
                );
              },
              icon: const Icon(Icons.info_outline, color: Color(0xFF0A2152)),
              label:  Text(
                "About Us",
                style: TextStyle(fontSize: 18, color: Color(0xFF0A2152)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
            ),

            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}