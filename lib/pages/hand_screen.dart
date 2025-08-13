import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HandPage(categoryTitle: 'Hand'.tr()
      ),
    );
  }
}

class HandItem {
  final String imagePath;
  final String name;
  final String size;
  final String description;
  final String priceRange;

  HandItem({
    required this.imagePath,
    required this.name,
    required this.size,
    required this.description,
    required this.priceRange,
  });
}

class HandPage extends StatefulWidget {
  final String categoryTitle;

   HandPage({super.key, required this.categoryTitle});

  @override
  State<HandPage> createState() => _HandPageState();
}

class _HandPageState extends State<HandPage> {
  TextEditingController searchController = TextEditingController();

  final List<HandItem> allItems = [
    HandItem(
      imagePath: 'assets/images/hand1.jpg',
      name: 'Basic Hand',
      size: 'Medium',
      description: 'Standard prosthetic hand for daily use.',
      priceRange: '500\$ - 650\$',
    ),
    HandItem(
      imagePath: 'assets/images/hand2.jpg',
      name: 'Advanced Grip Hand',
      size: 'Large',
      description: 'Enhanced grip with robotic control.',
      priceRange: '700\$ - 800\$',
    ),
    HandItem(
      imagePath: 'assets/images/hand3.jpg',
      name: 'Lightweight Hand',
      size: 'Small',
      description: 'Light and comfortable for long wear.',
      priceRange: '550\$ - 700\$',
    ),
    HandItem(
      imagePath: 'assets/images/hand4.jpg',
      name: 'Advanced Grip Hand',
      size: 'Large',
      description: 'Enhanced grip with robotic control.',
      priceRange: '720\$ - 820\$',
    ),
  ];

  List<HandItem> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void filterSearch(String query) {
    final results = allItems.where((item) {
      final lowerQuery = query.toLowerCase();
      return item.name.tr().toLowerCase().contains(lowerQuery) ||
          item.size.tr().toLowerCase().contains(lowerQuery) ||
          item.description.tr().toLowerCase().contains(lowerQuery);
    }).toList();

    setState(() {
      filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1CB5A3),
        title: Text(
          widget.categoryTitle.tr(),
          style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1CB5A3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: filterSearch,
                      decoration:  InputDecoration(
                        hintText: 'Search...'.tr(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1CB5A3),
                  ),
                  onPressed: () {
                    setState(() {
                      filteredItems.sort((a, b) => a.name.compareTo(b.name));
                    });
                  },
                  child:  Text("Sort by Name".tr(), style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1CB5A3),
                  ),
                  onPressed: () {
                    setState(() {
                      filteredItems.sort((a, b) => a.priceRange.compareTo(b.priceRange));
                    });
                  },
                  child:  Text("Sort by Price".tr(), style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: filteredItems.isEmpty
                  ?  Center(child: Text("No items found!".tr(), style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.imagePath,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(item.size.tr(), style:  TextStyle(color: Colors.grey)),
                                Text(item.priceRange.tr(),
                                    style: const TextStyle(color: Colors.green)),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 32,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1CB5A3),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => HandDetailsPage(item: item),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "View Details".tr(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
        bottomNavigationBar:Stack(
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
                      onPressed: () => Navigator.pushNamed(context, '/aboutus')
                  ),
                  IconButton(
                    icon: Icon(Icons.email, size: 40, color: Colors.teal),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        )

    );
  }
}

class HandDetailsPage extends StatelessWidget {
  final HandItem item;

  const HandDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name.tr(), style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1CB5A3),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(item.imagePath, height: 200),
            const SizedBox(height: 20),
            Text(
              item.description.tr(),
              style:  TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Price Range: ${item.priceRange}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1CB5A3),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {

              },
              child:  Text("Buy Now".tr(), style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
