import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'arm_screen.dart';
import 'gloves_screen.dart';
import 'hand_screen.dart';
import 'leg_screen.dart';
import 'Aboutus.dart';
import 'feedback.dart';
import 'SettingsPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> allItems = [
    {
      'label': 'Hand',
      'image': 'assets/images/IMG-20250804-WA0030.jpg',
    },
    {
      'label': 'Leg',
      'image': 'assets/images/Screenshot 2025-08-06 021812.png',
    },
    {
      'label': 'Arm',
      'image': 'assets/images/arm.png',
    },
    {
      'label': 'Gloves',
      'image': 'assets/images/OIP.png',
    },
  ];

  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void _filterItems(String query) {
    final result = allItems
        .where((item) =>
        item['label'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredItems = result;
    });
  }

  void _navigateToScreen(String label) {
    switch (label) {
      case 'Hand':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HandPage(categoryTitle: label),
          ),
        );
        break;
      case 'Leg':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(categoryTitle: label),
          ),
        );
        break;
      case 'Arm':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArmPage(categoryTitle: label),
          ),
        );
        break;
      case 'Gloves':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GlovesPage(categoryTitle: label),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Enhanced Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header with logo and menu
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.medical_services,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SANAD".tr(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0A2152),
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              "Medical Technology",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, color: Color(0xFF0A2152)),
                          onSelected: (value) {
                            if (value == 'settings') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Setting()),
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'settings',
                              child: Row(
                                children: [
                                  const Icon(Icons.settings, size: 20),
                                  const SizedBox(width: 12),
                                  Text('Settings'.tr()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Enhanced Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search products...'.tr(),
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      onChanged: _filterItems,
                    ),
                  ),
                ],
              ),
            ),
            
            // Product Categories Grid
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                  children: filteredItems.map((item) {
                    return _buildProductCard(item);
                  }).toList(),
                ),
              ),
            ),
            
            // Enhanced Bottom Navigation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        icon: Icons.home_rounded,
                        label: 'Home',
                        isActive: true,
                        onTap: () => Navigator.pushNamed(context, "/Sign in"),
                      ),
                      _buildNavItem(
                        icon: Icons.info_outline_rounded,
                        label: 'About',
                        onTap: () => Navigator.pushNamed(context, '/aboutus'),
                      ),
                      _buildNavItem(
                        icon: Icons.email_outlined,
                        label: 'Contact',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProductCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _navigateToScreen(item['label'].toString()),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.teal.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            
            // Content section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['label'].toString().tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0A2152),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Professional grade',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'View Products',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.teal.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.teal.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.teal : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.teal : Colors.grey.shade600,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home, size: 40, color: Colors.teal),
                        onPressed: () => Navigator.pushNamed(context, "/Sign in"),
                      ),
                      IconButton(
                        icon: Icon(Icons.info, size: 40, color: Colors.teal),
                        onPressed: () {
                          // فتح صفحة About Us
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.email, size: 40, color: Colors.teal),
                        onPressed: () {
                          // فتح الإيميل أو صفحة التواصل
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
