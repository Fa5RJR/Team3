import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'arm_screen.dart';
import 'gloves_screen.dart';
import 'hand_screen.dart';
import 'leg_screen.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "SANAD".tr(),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'settings',
                child: Text('Settings'.tr()),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text('Logout'.tr()),
              ),
            ],
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...'.tr(),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: _filterItems,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: EdgeInsets.all(16),
                childAspectRatio: 0.8,
                children: filteredItems.map((item) {
                  return ElevatedButton(
                    onPressed: () {
                      _navigateToScreen(item['label'].toString());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(8),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          item['label'].toString().tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Stack(
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
                        icon: Icon(Icons.person, size: 40, color: Colors.teal),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.save, size: 40, color: Colors.teal),
                        onPressed: () {},
                      ),
                      SizedBox(width: 60),
                      IconButton(
                        icon: Icon(Icons.settings, size: 40, color: Colors.teal),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.comment, size: 40, color: Colors.teal),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -28,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.home,
                      size: 34,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}